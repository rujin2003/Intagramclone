

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:instagramclone/Pages/Posts.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'Functions.dart';

class userProfile extends StatefulWidget {
 final String username;
 final String profilepc;
 final String fullname;
 final String? bio;
final String follower;
 final  String following;
  final String posts;
  final String email;


  
 userProfile({super.key,required this.username,required this.profilepc,this.bio,required this.fullname,required this.follower,required this.following,required this.posts,required this.email});

  @override
  State<userProfile> createState() => _ProfileState();
}






class _ProfileState extends State<userProfile> {
 



TextEditingController bio =TextEditingController();
bool folllowed=false;
  bool bioOption=true;
  
  
@override
  
  
  @override
  Widget build(BuildContext context) {
  
    
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            IconButton(onPressed: (() { 
           Get.back();
                  Future.delayed(Duration(seconds: 3), (){
                       
                     Provider.of<Functions>(context,listen: false).searchedUser=null; 
                
                       });
                          
           
             
            }), icon:Icon(Icons.arrow_back_ios)),
            SizedBox(width: 5,),
            Container(
            margin: EdgeInsets.only(left: 20),
            child: Text(widget.username,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
             
             
            
            
            )]),
       SizedBox(height: 30,),
       Row(children: [
        SizedBox(width: 10,),
        widget.profilepc!="none"?
             Column(
               children: [
                 Container(
                           height: 70,
                          width: 70,
                          
                          decoration: BoxDecoration(
                          
                            borderRadius: BorderRadius.circular(36) ,image: DecorationImage(image: NetworkImage(widget.profilepc),fit: BoxFit.cover)),
                          ),
                          SizedBox(height: 5,),
                          Text(widget.bio??"",style: TextStyle(fontWeight: FontWeight.bold),)
               ],
             ): Column(
               children: [
                 Container(
                           height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                           color: Colors.blue,
                           
                            borderRadius: BorderRadius.circular(36) ,image: DecorationImage(image: AssetImage("images/profile.png"),fit: BoxFit.cover)),
                          ),
                            SizedBox(height: 5,),
                          Text(widget.bio??"",style: TextStyle(fontWeight: FontWeight.bold),)
               ],
             ),
                      SizedBox(width: 50,),
                      
                      Column(
              children: [
                Row(children: [Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Text(widget.posts,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    const Text("Posts")
                  ],),
                    const SizedBox(width: 20,),
                    Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Text(Provider.of<Functions>(context).searchedUser!["follower"].toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    const Text("Followers"),
                  ],),
                    const SizedBox(width: 20,),
                   Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Text(widget.following,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    const Text("Following"),
                  ],)],),
                  const SizedBox(height: 7,),
                    Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


          Provider.of<Functions>(context).followed == false ?
           
            ButtonTheme(
                minWidth: 150,
  height: 20,
              child:
              
               ElevatedButton(onPressed: (() {
                Provider.of<Functions>(context,listen: false).followed = true;
                 Provider.of<Functions>(context,listen: false).follower(widget.email,);
                Provider.of<Functions>(context,listen: false).following(widget.email,widget.profilepc,widget.username);
                

              }),
              child:Container(
                width: 100,
                height: 20,
                child: const Center(child: Text("follow"),),)),
            ):ButtonTheme(
                minWidth: 150,
  height: 20,
              child:
              
               ElevatedButton(
                 style: ButtonStyle(
    backgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
  ),
                onPressed: (() {
                 Provider.of<Functions>(context,listen: false).followed =false;
                Provider.of<Functions>(context,listen: false).unfollow(widget.email);
                Provider.of<Functions>(context,listen: false).removefollower(widget.email);
              }),
              child:Container(
                width: 100,
                height: 20,
                child: const Center(child: Text("following",style: TextStyle(color: Colors.black),),),)),
            ),
              ],),
             
              ],
            ), 
                      ],),
        SizedBox(height: 20,),
        Posts(email: widget.email,)
      
      ],),
    );
  }
}