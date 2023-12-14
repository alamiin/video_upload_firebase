
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffmpeg_kit_flutter/media_information_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:video_upload_firebase/helper/language.dart';
import 'package:video_upload_firebase/service/video_meta_data_service.dart';

import '../data/repository/home_repo.dart';
import '../service/video_provider_service.dart';


class HomeProvider extends ChangeNotifier with VideoProviderService, VideoMetaDataService{

  final HomeRepo homeRepo;

  HomeProvider({required this.homeRepo});

  String _videoPath = "";
  bool isLoading = false;

  ///This function is used for selecting and uploading meta data to server
  /// In this function have some logic
  /// 1. checking data already in processing
  /// 2. Internet checking
  /// 3. then selecting and uploading
  void getVideo(ImageSource imageSource) async {

    if(isLoading) return;

    bool hasInternet = await InternetConnectionChecker().hasConnection;
    if(hasInternet == false){
      EasyLoading.showError(AppLanguage.noInternetMessage);
      return;
    }

    var videoPath = await getPickVideo(imageSource);
    if(videoPath != null){
      updateLoder(true, 'Uploading...');
      _videoPath = videoPath;
       getMetaData(videoPath, getVideoMetaData);
    }
  }

  /// This is a helper function of GETVIDEO.
  /// this function is receive metadata information
  /// then extract metadata
  /// then upload to the server
  Future<void> getVideoMetaData(MediaInformationSession session) async{
    var metaData =  await extractMetaData(session, _videoPath);
    await homeRepo.uploadVideoMetaData(metaData);
    updateLoder(false, "");
  }

  /// this function is used for showing working state
  void updateLoder(bool state, String message){
    isLoading = state;
    if(isLoading){
      EasyLoading.show(status: message);
    }else{
      EasyLoading.dismiss();
    }
  }

  /// this function is used for deleting
  Future<void> deleteVideoMetaData(String videoId) async {

    if(isLoading) return;

    bool hasInternet = await InternetConnectionChecker().hasConnection;
    if(hasInternet == false){
      EasyLoading.showError(AppLanguage.noInternetMessage);
      return;
    }

    updateLoder(true, "Deleting...");
    var response = await homeRepo.deleteVideoMetaData(videoId);
    updateLoder(false, "");

    if (response.code != 200) {
      EasyLoading.showError(response.message!);
    }

  }

  /// this function is used for fetching data from server
  Stream<QuerySnapshot> fetchVideoMetaData(){
    return homeRepo.readVideoMetaData();
  }


}