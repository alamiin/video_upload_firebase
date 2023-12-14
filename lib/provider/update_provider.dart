
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffmpeg_kit_flutter/media_information_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:video_upload_firebase/data/repository/update_repo.dart';
import 'package:video_upload_firebase/helper/language.dart';
import 'package:video_upload_firebase/service/video_meta_data_service.dart';

import '../data/repository/home_repo.dart';
import '../service/video_provider_service.dart';


class UpdateProvider extends ChangeNotifier {

  final UpdateRepo updateRepo;

  UpdateProvider({required this.updateRepo});

  bool isLoading = false;

  /// this function is used for showing working state
  void updateLoder(bool state, String message){
    isLoading = state;
    if(isLoading){
      EasyLoading.show(status: message);
    }else{
      EasyLoading.dismiss();
    }
  }

  /// this function is used for update meta data
  Future<void> updateVideoMetaData(String videoId, Map<String, dynamic> metaData) async {

    if(isLoading) return;

    bool hasInternet = await InternetConnectionChecker().hasConnection;
    if(hasInternet == false){
      EasyLoading.showError(AppLanguage.noInternetMessage);
      return;
    }

    updateLoder(true, "updating...");
    var response = await updateRepo.updateVideoMetaData(videoId, metaData);
    updateLoder(false, "");

    if (response.code != 200) {
      EasyLoading.showError(response.message!);
    }

  }

}