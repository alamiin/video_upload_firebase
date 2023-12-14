import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_upload_firebase/provider/update_provider.dart';

import '../common/custom_button.dart';
import '../common/custom_widget.dart';

class UpdatePage extends StatefulWidget {
  final String fileName;
  final String fileSize;
  final String duration;
  final String codecTagString;
  final String creationTime;
  final String videoId;
  const UpdatePage({Key? key, required this.fileName, required this.fileSize, required this.duration, required this.codecTagString, required this.creationTime, required this.videoId}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  late TextEditingController _durationController;
  late TextEditingController _codecTagController;
  late TextEditingController _creationTimeController;
  late TextEditingController _fileNameController;
  late TextEditingController _fileSizeController;

  @override
  void initState() {
    _durationController = TextEditingController(text: widget.duration);
    _codecTagController = TextEditingController(text: widget.codecTagString);
    _creationTimeController = TextEditingController(text: widget.creationTime);
    _fileNameController = TextEditingController(text: widget.fileName);
    _fileSizeController = TextEditingController(text: widget.fileSize);
    super.initState();
  }

  @override
  void dispose() {
    _durationController.dispose();
    _codecTagController.dispose();
    _creationTimeController.dispose();
    _fileNameController.dispose();
    _fileSizeController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    return Scaffold(

      appBar: customAppBar(
        context: context,
        title: "Update",
        isNotHome: true
      ),

      body: SafeArea(
          child: Scrollbar(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 60),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: _fileNameController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: _durationController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: _fileSizeController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: _codecTagController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextField(
                            controller: _creationTimeController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),




                  CustomButton(width: buttonWidth, name: "Update",
                      onPressed: (){


                        if(
                        _fileNameController.text != widget.fileName ||
                            _fileSizeController.text != widget.fileSize ||
                            _durationController.text != widget.duration ||
                            _codecTagController.text != widget.codecTagString ||
                            _creationTimeController.text != widget.creationTime
                        ){

                          var metaData = {
                            "duration" : _durationController.text,
                            "creation_time" : _creationTimeController.text,
                            "codec_tag_string" : _codecTagController.text,
                            "name" : _fileNameController.text,
                            "size" : _fileSizeController.text
                          };
                          Provider.of<UpdateProvider>(context, listen: false).updateVideoMetaData(widget.videoId, metaData);

                        }

                      }),

                  const SizedBox(height: 20,)

                ],
              ),
            ),
          )),

    );
  }
}
