import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/response.dart';
class FirebaseService{

  late CollectionReference _fbVideos;
  FirebaseService(){
    _fbVideos = FirebaseFirestore.instance.collection('my_videos');
  }


  Future<Response> uploadVideoMetaData(Map<String, dynamic> metaData) async {
    Response response = Response();
    await _fbVideos.add(metaData).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e.toString();
    });
    return response;
  }

  Stream<QuerySnapshot> readVideoMetaData() {
    CollectionReference notesItemCollection = _fbVideos;
    return notesItemCollection.snapshots();
  }

  Future<Response> updateVideoMetaData({
    required String videoId,
    required Map<String, dynamic> metaData
  }) async {
    Response response = Response();
    DocumentReference documentReferencer =
    _fbVideos.doc(videoId);

    await documentReferencer
        .update(metaData)
        .whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated Video Metadata";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  Future<Response> deleteVideoMetaData({
    required String videoId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _fbVideos.doc(videoId);
    await documentReferencer
        .delete()
        .whenComplete((){
      response.code = 200;
      response.message = "Sucessfully Deleted Video Metadata";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }


}