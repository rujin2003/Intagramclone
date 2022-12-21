import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:instagramclone/Mainpages.dart';
import 'package:instagramclone/Pages/Homepage.dart';
import 'package:instagramclone/Pages/LoginPage.dart';
class Userentry{

userLogin(user,password,context)async{

 try {
  await FirebaseAuth.instance.signInWithEmailAndPassword(email: user, password: password);
  Get.off(Mainpages());
 } catch (e) {
   showDialog(context: context, builder: ((context) {
     return AlertDialog(title:const Text("Error!"),
     content: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      height: 100,width: 100,child: Column(
      children:  [const Expanded(child: SizedBox(height: 10,)),
        const Text("wrong Email or Password"),
         
        const Expanded(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          ElevatedButton(onPressed: (() {
             Navigator.of(context).pop();
          }), child:const Text("cancel"),
         ) ],)


      ],
     ),),
     );
   }));
 }

}
userSignup(email,password,username,fullname,context)async{
  try {
  await  FirebaseAuth.instance.createUserWithEmailAndPassword(email:email, password: password);
  await  FirebaseFirestore.instance.collection("Users").doc(email).set({
      "email":email,
      "username":username,
      "fullname":fullname,
      "follower":0,
      "posts":0,
      "following":0,
      "profilepc":"none"
    });
   Get.to(Login());

  } catch (e) {
    AlertDialog(title:const Text("Error!"),
     content: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      height: 100,width: 100,child: Column(
      children:  [const Expanded(child: SizedBox(height: 10,)),
        const Text("Email already in use"),
         
        const Expanded(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          ElevatedButton(onPressed: (() {
             Navigator.of(context).pop();
          }), child:const Text("cancel"),
         ) ],)


      ],
     ),),
     );
  }
}

}
