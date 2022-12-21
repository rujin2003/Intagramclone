import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Posts extends StatefulWidget {
  final String email;
  const Posts({super.key,required this.email});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      
      stream: FirebaseFirestore.instance.collection('Users').doc(widget.email).collection('Posts').snapshots(),
      builder: ((context,AsyncSnapshot snapshot) {
      
      if(snapshot.hasData){
         return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder:((context, index) {
           return Wrap(
             children: [
               Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    boxShadow: [
      BoxShadow(
        color: Color(0xffDDDDDD),
        blurRadius: 6.0,
        spreadRadius: 2.0,
        offset: Offset(0.0, 0.0),
      )
    ],
                    
                    color: Colors.white,image: DecorationImage(image:NetworkImage(snapshot.data!.docs[0]['image']),fit: BoxFit.cover )),
                 ),
               ),
             ],
           );
         }));
      }else{
          return 
       Container(
      height: 300,
            width: 350,
      child: Column(children: const [
       SizedBox(height: 50,),
        Icon(Icons.add_a_photo_rounded,size: 50,),
        Text("No posts yet",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      
      ],),
    );
      }
    }));
  }
}
