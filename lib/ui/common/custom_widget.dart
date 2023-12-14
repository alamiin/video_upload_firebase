import 'package:flutter/material.dart';

customAppBar({required BuildContext context, required String title, required bool isNotHome}){
  return AppBar(

    leading: isNotHome ? IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.white),
      onPressed: (){
        Navigator.of(context).pop();
      },
    ): null ,

    title: Text(title, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),),
    backgroundColor: Colors.blue,
  );
}

customFlotingActionButton(
    {required BuildContext context, required String name, required Function() callbackAction}){
  return FloatingActionButton.extended(
    onPressed: callbackAction,
    label: Text(name, style: const TextStyle(fontSize: 18, color: Colors.white),),
    backgroundColor: Colors.blue,
    shape: RoundedRectangleBorder(side:const BorderSide(width: 2,color: Colors.black87),borderRadius: BorderRadius.circular(45)),
  );
}