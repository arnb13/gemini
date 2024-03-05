import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gemini/src/constant/page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final storage = GetStorage();
  storage.writeIfNull('token', '');
  storage.writeIfNull('isLoggedIn', false);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  Gemini.init(apiKey: '');


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gemini',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fade,
      getPages: Routes.route,
      initialRoute: RouteConstant.HOME,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
