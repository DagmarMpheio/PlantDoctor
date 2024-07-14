import 'package:apptest/firebase_options.dart';
import 'package:apptest/pages/SomethingWentWrong.dart';
import 'package:apptest/pages/homeScreen.dart';
import 'package:apptest/pages/plantList.dart';
import 'package:apptest/pages/selectlang.dart';
import 'package:apptest/pages/selectplants.dart';
import 'package:apptest/pages/splash_screen.dart';
import 'package:apptest/services/auth.dart';
import 'package:apptest/services/localization_service.dart';
import 'package:apptest/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:apptest/pages/home.dart';
//import 'package:apptest/pages/previous_reports.dart';
//import 'package:apptest/pages/title.dart';
import 'package:apptest/pages/login.dart';
//import 'package:apptest/pages/report.dart';
import 'package:apptest/pages/signup.dart';

import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:apptest/models/user.dart';
//import 'package:camera/camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(App());
}

class App extends StatelessWidget {
  final lang = LocalizationService();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LocalizationService(),
      locale: lang.getCurrentLocale(),
      fallbackLocale: Locale('en', 'US'),
      home: FutureBuilder(
        // Initialize FlutterFire
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          } else if (snapshot.hasError) {
            return SomethingWentWrong();
          } else {
            return StreamProvider<MyUser?>.value(
                catchError: (context, e) {
                  print(e.toString());
                },
                initialData: null,
                value: AuthService().user,
                child: Wrapper());
          }
        },
      ),
      routes: {
        //'/title': (context) => title(),
        '/splashscreen': (context) => SplashScreen(),
        '/change_lang': (context) => Selectlang(),
        '/login': (context) => login(),
        //'/report': (context) => report(),
        '/homeScreen': (context) => homeScreen(),
        '/previous_reports': (context) => plantList(),
        '/selectPlants': (context) => selectPlants(),
        '/signup': (context) => signup(),
        //'/scan': (context) => TakePictureScreen(camera: camera,),
      },
    );
  }
}
