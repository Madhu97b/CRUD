// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_and_firebase/pages/employee.dart';
// import 'package:flutter_and_firebase/pages/home.dart';
import 'package:flutter_application_4/pages/home.dart';
import 'package:flutter_application_4/pages/employee.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //01
  // await Firebase.initializeApp(); //02 To enable the Firebase in our Flutter App
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    // home: Home(),
    initialRoute: '/',
    routes: {
      '/': (context) => const Home(),
      '/employee': (context) => const Employee(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
