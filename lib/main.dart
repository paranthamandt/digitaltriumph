import 'package:firstapipro/routes/apppage.dart';
import 'package:firstapipro/routes/approutes.dart';
import 'package:flutter/material.dart';
import 'package:firstapipro/core/constants/appconstants.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/storageservices/serviceskey.dart';
import 'package:path_provider/path_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(Appconstants.userHiveBox);
  runApp(MyApp());
}
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   final directory = await getApplicationDocumentsDirectory();
//   Hive.init(directory.path);
//
//   await Hive.openBox(Appconstants.userHiveBox);
//
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Inter"),

      initialRoute: Apppage.splashscreen,

      getPages: Approutes.page,
    );
  }
}
