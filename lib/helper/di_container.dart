
import 'package:get_it/get_it.dart';
import 'package:video_upload_firebase/data/firebase/firebase_service.dart';
import 'package:video_upload_firebase/data/repository/update_repo.dart';
import '../data/repository/home_repo.dart';
import '../provider/home_provider.dart';
import '../provider/update_provider.dart';


final sl = GetIt.instance;

Future<void> init() async {

  // Provider
  sl.registerFactory(() => HomeProvider(homeRepo: sl()));
  sl.registerFactory(() => UpdateProvider(updateRepo: sl()));

  //Repository
  sl.registerFactory(() => HomeRepo(firebaseService: sl()));
  sl.registerFactory(() => UpdateRepo(firebaseService: sl()));

  // External
  sl.registerFactory(() => FirebaseService());

}
