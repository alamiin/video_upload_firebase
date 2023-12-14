
import 'package:ffmpeg_kit_flutter/ffprobe_kit.dart';
import 'package:ffmpeg_kit_flutter/media_information_session.dart';
import 'package:ffmpeg_kit_flutter/media_information_session_complete_callback.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:video_upload_firebase/helper/extension_function.dart';
mixin VideoMetaDataService{

  void getMetaData(String path, MediaInformationSessionCompleteCallback callBack) async {
    await FFprobeKit.getMediaInformationAsync(path, callBack);
  }

  Future<Map<String, String>> extractMetaData(MediaInformationSession session, String path) async{

    String videoDuration = "";
    String codecTagString = "";
    String creationTime = "";
    String fileName = "";
    String fileSize = "";

    final information = (session).getMediaInformation();
    if(information != null){
      fileName = path.split('/').last;
      fileSize = information.getSize() ?? "";
      videoDuration = information.getDuration() ?? "";
      creationTime = information.getTags()!["creation_time"] ?? "";
    }
    try {
      for (int x = 0; x < information!.getStreams().length; x++) {
        final stream = information.getStreams()[x];
        if (stream.getAllProperties() != null) {
          if(stream.getAllProperties()!["codec_tag_string"] != null){
            codecTagString = stream.getAllProperties()!["codec_tag_string"].toString();
          }
          break;
        }
      }

      var result = {
        "duration" : videoDuration,
        "creation_time" : creationTime.readableDate(),
        "codec_tag_string" : codecTagString,
        "name" : fileName,
        "size" : fileSize.readableFileSize()
      };

      return result;

    } catch (e) {
      var result = {
        "duration" : videoDuration,
        "creation_time" : creationTime,
        "codec_tag_string" : codecTagString,
        "name" : fileName,
        "size" : fileSize
      };

      return result;
    }
  }

}