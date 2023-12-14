import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_upload_firebase/provider/home_provider.dart';
import 'package:video_upload_firebase/ui/common/custom_widget.dart';
import 'package:video_upload_firebase/ui/home/widget/video_picker_dialog.dart';

import 'widget/meta_data_widget.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton:  customFlotingActionButton(
          context: context,
          name: "Upload Video",
          callbackAction: (){
            videoPickerDialog(context);
          }
      ),

      appBar: customAppBar(
          context: context,
          title: "Home",
          isNotHome: false
      ),

      body: StreamBuilder(
        stream: Provider.of<HomeProvider>(context, listen: false).fetchVideoMetaData(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
              child: ListView(
                children: snapshot.data!.docs.map((e) {
                  return MetaDataWidget(
                    fileName: e["name"],
                    fileSize: e['size'],
                    duration: e['duration'],
                    codecTagString: e['codec_tag_string'],
                    creationTime: e['creation_time'],
                    videoId: e.id,
                  );
                }).toList(),
              ),
            );
          }
          return Container();
        },
      ),
    );

  }




}
