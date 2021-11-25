import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rider_app/AllScreens/loginScreen.dart';
import 'package:rider_app/AllScreens/mainscreen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:rider_app/AllScreens/registrationScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    runApp(
  DevicePreview(
    builder: (context) => MyApp(), // Wrap your app
  ),
);
}

DatabaseReference userRef=FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context), // Add the locale here
      builder: DevicePreview.appBuilder, // Add the builder here

      title: 'Uber Clone',
      theme: ThemeData(
        fontFamily: "Brand-Bold",
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: MainScreen.idScreen,
      routes: {
        RegistrationScreen.idScreen: (context) => RegistrationScreen(),
        LoginScreen.idScreen: (context) => LoginScreen(),
        MainScreen.idScreen: (context) => MainScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}


