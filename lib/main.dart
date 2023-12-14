import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_upload_firebase/provider/home_provider.dart';
import 'package:video_upload_firebase/provider/update_provider.dart';
import 'package:video_upload_firebase/ui/home/home_page.dart';
import 'helper/di_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'helper/easy_loading_init.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<HomeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<UpdateProvider>()),
    ],
    child: MyApp(),
  )
  );
  configLoading();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HomePage(),
      builder: EasyLoading.init(),
    );
  }
}

