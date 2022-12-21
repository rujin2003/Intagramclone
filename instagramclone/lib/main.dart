import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:instagramclone/Pages/Addpics.dart';
import 'package:instagramclone/Pages/Functions.dart';
import 'package:instagramclone/Pages/Homepage.dart';
import 'package:instagramclone/Pages/LoginPage.dart';
import 'package:instagramclone/Pages/ProfilePage.dart';
import 'package:instagramclone/Pages/SearchPage.dart';
import 'package:instagramclone/Pages/SignupPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 runApp(ChangeNotifierProvider(create: (_) => Functions(), child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int current_index = 0;
  List<Widget> pages= [Login(),Signup(),Addpost(),Profile()];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter InstagramClone',
      
      home: 
      Login()
    );
  }
}


