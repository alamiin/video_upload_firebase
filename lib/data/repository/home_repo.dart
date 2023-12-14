import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_upload_firebase/data/model/response.dart';
import 'package:video_upload_firebase/data/firebase/firebase_service.dart';

class HomeRepo{

  final FirebaseService firebaseService;
  HomeRepo({required this.firebaseService});

  Stream<QuerySnapshot> readVideoMetaData(){
    return firebaseService.readVideoMetaData();
  }

  Future<Response> uploadVideoMetaData(Map<String, dynamic> metaData){
    return firebaseService.uploadVideoMetaData(metaData);
  }

  Future<Response> deleteVideoMetaData(String videoId){
    return firebaseService.deleteVideoMetaData(videoId: videoId);
  }

}