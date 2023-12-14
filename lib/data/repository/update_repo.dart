import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_upload_firebase/data/model/response.dart';
import 'package:video_upload_firebase/data/firebase/firebase_service.dart';

class UpdateRepo{

  final FirebaseService firebaseService;
  UpdateRepo({required this.firebaseService});

  Future<Response> updateVideoMetaData(String videoId, Map<String, dynamic> metaData){
    return firebaseService.updateVideoMetaData(videoId: videoId, metaData: metaData);
  }

}