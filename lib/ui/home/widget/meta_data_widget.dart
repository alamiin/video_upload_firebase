import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_upload_firebase/provider/home_provider.dart';
import 'package:video_upload_firebase/ui/update/update_page.dart';
class MetaDataWidget extends StatelessWidget {
  final String fileName;
  final String fileSize;
  final String duration;
  final String codecTagString;
  final String creationTime;
  final String videoId;


  const MetaDataWidget({
    Key? key,
    required this.fileName,
    required this.fileSize,
    required this.duration,
    required this.codecTagString,
    required this.creationTime,
    required this.videoId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(children: [
          ListTile(
            title: Text(fileName),
            subtitle: Container(
              child: (Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Duration: " + duration + "Sce", style: const TextStyle(fontSize: 12)),
                  Text("Size: " + fileSize, style: const TextStyle(fontSize: 12)),
                  Text("Codec Tag: " + codecTagString, style: const TextStyle(fontSize: 12)),
                  Text("Created On: " + creationTime, style: const TextStyle(fontSize: 14)),
                ],
              )),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(5.0),
                  primary: const Color.fromARGB(255, 143, 133, 226),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text('Edit'),
                onPressed: () {
                  Navigator.pushAndRemoveUntil<dynamic>(
                    context,
                    MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) => UpdatePage(
                       fileName: fileName,
                        fileSize: fileSize,
                        duration: duration,
                        codecTagString: codecTagString,
                        creationTime: creationTime,
                        videoId: videoId,
                      ),
                    ),
                        (route) =>
                    true, //if you want to disable back feature set to false
                  );
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(5.0),
                  primary: const Color.fromARGB(255, 143, 133, 226),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                child: const Text('Delete'),
                onPressed: () async {
                  await Provider.of<HomeProvider>(context, listen: false).deleteVideoMetaData(videoId);
                },
              ),
            ],
          ),
        ]));
  }
}
