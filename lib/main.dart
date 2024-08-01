import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tesr_app/homepage.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyD8sti0tkemPcw1CsVnPwunzvEt8KmJZDI", 
      appId:  "1:942755546934:android:a648164d94ebbc0fb45597", 
      messagingSenderId: "942755546934", 
      projectId: "test1-f7295")
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
