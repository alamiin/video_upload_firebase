import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

mixin VideoProviderService{
  /// Get from gallery
  Future<String?> getPickVideo(ImageSource imageSource) async {
    try {
      final video = await ImagePicker().pickVideo(source: imageSource);
      if(video == null) return null;
      File imageFile = File(video.path);
      return imageFile.path;
    } on PlatformException catch(e) {
      return null;
    }
  }
}