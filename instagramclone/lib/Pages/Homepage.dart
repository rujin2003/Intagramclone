import 'package:flutter/material.dart';
import 'package:instagramclone/Homepageposts.dart';
import 'package:instagramclone/Pages/Functions.dart';
import 'package:instagramclone/Pages/Userprofilepage.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title:
    
       Container(
        height: 40,
        width: 150,
        decoration: BoxDecoration(
         
          image: DecorationImage(image: AssetImage("images/instagram.png"),fit: BoxFit.contain, )),
         
       ),
      toolbarHeight: 50,
      backgroundColor: Colors.white,
      
      ),
      body:
      
       FutureBuilder(
        future: Provider.of<Functions>(context).getuserProfile(),
        builder: ((context,snapshot) {//future builder
    
        
      return StreamBuilder(
       stream: FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.email).collection("Following").snapshots(),
        builder: ((context,AsyncSnapshot following) {


         if(following.hasData && following.data.docs!=null){
        
          //list view for following
          return Container(
            
            
            child: ListView.builder(
               shrinkWrap: true,
              itemCount: following.data!.docs.length,
              itemBuilder: ((context, index) {
        
            return  StreamBuilder(
              stream: FirebaseFirestore.instance.collection("Users").doc(following.data!.docs[index]['email']).collection("Posts").snapshots(),
              builder: ((context, post) {
    
              if (post.hasData && post.data!.docs.isNotEmpty  ) {
         
                return Container(
                  
                  
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: post.data!.docs.length,
                      itemBuilder: ((context, indexx) {
                      return HomepagePosts(postImage:post.data!.docs[indexx]['image'] , username: following.data!.docs[index]['username'], profilepc: following.data!.docs[index]['profilepc'], caption: "This is a random caption",email:following.data!.docs[index]['email'],index: indexx,
                      
                      liked: post.data!.docs[indexx]['likes'].contains(Provider.of<Functions>(context).userProfile["username"])? true:false,
                      
                      );
                    })),
                  ),
                );
              } else {
                return Center(child: Container(
                  
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 200,),
                  Icon(Icons.apps_outage_sharp,size: 50,color: Colors.grey,),
                  Text("No Posts Yet",style: TextStyle(fontFamily: "satisfy",fontSize: 50,color: Color.fromRGBO(189, 195, 199 ,100)),)
                ],)));
              }
            }));
            })),
          );
         }else{
          return  Center(child: Container(
                  
                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 200,),
                  Icon(Icons.apps_outage_sharp,size: 50,color: Colors.grey,),
                  Text("No Posts Yet",style: TextStyle(fontFamily: "satisfy",fontSize: 50,color: Color.fromRGBO(189, 195, 199 ,100)),)
                ],)));
         }
       }));
      })),
    );
  }
} 
// const Center(child: HomepagePosts(postImage: "https://firebasestorage.googleapis.com/v0/b/instagramclone-9b59f.appspot.com/o/profilepc%2Frujin.___?alt=media&token=e794bc6b-7c10-4878-ad89-4ed3951a47b2",profilepc: "https://firebasestorage.googleapis.com/v0/b/instagramclone-9b59f.appspot.com/o/profilepc%2Frujin.___?alt=media&token=e794bc6b-7c10-4878-ad89-4ed3951a47b2",username: "rujin.__",caption: "this is caption",));