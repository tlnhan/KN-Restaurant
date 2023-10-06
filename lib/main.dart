import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kn_restaurant/screens/splash_screen.dart';
import 'package:kn_restaurant/utils/const.dart';
import 'package:kn_restaurant/utils/utils.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GetMaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.green,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white)),
      title: Constants.appName,
      // theme: Constants.lightTheme,
      // darkTheme: Constants.darkTheme,
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
