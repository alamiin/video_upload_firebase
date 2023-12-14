
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_upload_firebase/helper/language.dart';
import 'package:video_upload_firebase/provider/home_provider.dart';
import 'package:video_upload_firebase/ui/common/custom_button.dart';

Future<void> videoPickerDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: const Color(0xFF4F4F4F),
          content: Container(
            width: 200,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(4)),
                border: Border.all(color: Colors.white, width: 1.5,)
            ),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: const Text(AppLanguage.chooseVideoSource, style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87
                  ),),
                ),

                const Divider(),

                const SizedBox(height: 20,),

                CustomButton(width: 200, name: AppLanguage.camera, onPressed: (){
                  Provider.of<HomeProvider>(context, listen: false).getVideo(ImageSource.camera);
                  Navigator.pop(context);
                }),

                const SizedBox(height: 10,),

                CustomButton(width: 200, name: AppLanguage.gallery,
                    onPressed: (){
                      Provider.of<HomeProvider>(context, listen: false).getVideo(ImageSource.gallery);
                      Navigator.pop(context);
                    }),

                const SizedBox(height: 20,),

              ],
            ),
          )

      );
    },
  );
}