

import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Functions extends ChangeNotifier{
var userProfile = {};
Map? searchedUser;
bool? followed;
String? checkfollow;
bool? liked;

//get user data 
 Future getuserProfile() async {
    var response = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
        userProfile=response.docs[0].data();
        notifyListeners();
    
  }
  //add bio to user data 
  addbio(bio,)async{
    userProfile['bio']=bio;
    await FirebaseFirestore.instance.collection("Users").doc(userProfile["email"]).update({"bio":bio});
    notifyListeners();
  }
  //upload a profile picture
addProfileimg(image)async{
final ref = FirebaseStorage.instance.ref().child("profilepc").child(userProfile["username"]);
await ref.putFile(image);
final url = await ref.getDownloadURL();

userProfile['profilepc']=url;
await FirebaseFirestore.instance.collection("Users").doc(userProfile["email"]).update({"profilepc":url});
    notifyListeners();

}

//search for usernames
 Searchfunction(searchedUsername)async{
    var response = await FirebaseFirestore.instance.collection('Users').where('username',isEqualTo:searchedUsername ).get();
    searchedUser=response.docs[0].data();
    
notifyListeners();


  }
  
//follow following 

  following(email,profilepc,username)async{
 
  await FirebaseFirestore.instance.collection("Users").doc(userProfile["email"]).update({"following":userProfile["following"]+1});
   await  FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.email).collection("Following").doc(email).set({"email":email,"profilepc":profilepc,"username":username});
   userProfile["following"]=userProfile["following"]+1;
  
     notifyListeners();
    }
  unfollow(email)async{
     await  FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser!.email).collection("Following").doc(email).delete();
  await FirebaseFirestore.instance.collection("Users").doc(userProfile["email"]).update({"following":userProfile["following"]-1});
    userProfile["following"]=userProfile["following"]-1;
    followed=false;
     notifyListeners();
  }

  follower(email)async{
     await  FirebaseFirestore.instance.collection('Users').doc(email).collection("Follower").doc(FirebaseAuth.instance.currentUser!.email).set({"email":FirebaseAuth.instance.currentUser!.email,"username":userProfile["username"],"profilepc":userProfile["profilepc"]});
  await FirebaseFirestore.instance.collection("Users").doc(email).update({"follower":userProfile["follower"]+1});
  searchedUser!["follower"]=searchedUser!["follower"]+1;
  

  
     notifyListeners();
  }

   removefollower(email)async{
     await  FirebaseFirestore.instance.collection('Users').doc(email).collection("Follower").doc(FirebaseAuth.instance.currentUser!.email).delete();
  await FirebaseFirestore.instance.collection("Users").doc(email).update({"follower":userProfile["follower"]-1});
    searchedUser!["follower"]=searchedUser!["follower"]-1;
    notifyListeners();
  }


followercheck(email)async{


 await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.email).collection("Following")
  .where('email', isEqualTo:email).get().then((value) =>{value.docs.forEach((element) {
  
    
   checkfollow = element.data()["email"];
   
     
    }
 
  
  )
  }) ;

  if(checkfollow==email){
    followed=true;
    notifyListeners();
  }else{
    followed=false;
    notifyListeners();
  }
}
//****** */

//add posts in firebase 

addposts(image,caption,)async{
final ref = FirebaseStorage.instance.ref().child("Posts").child(userProfile["username"]);
await ref.putFile(image);
final url = await ref.getDownloadURL();
await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser!.email).collection("Posts").doc(userProfile["posts"].toString()).set({"image":url,"caption":caption,"likes":FieldValue.arrayUnion([])});
userProfile["posts"]=userProfile["posts"]+1;
await FirebaseFirestore.instance.collection("Users").doc(userProfile["email"]).update({"posts":userProfile["posts"]+1});
 
}


likes(username,email,index)async{
  var ola=index+1;
await FirebaseFirestore.instance
        .collection('Users').doc(email).collection("Posts")
        .doc(ola.toString()).update({"likes":FieldValue.arrayUnion([username])});

}



unlike(username,email,index)async{
 var ola=index+1;
 await FirebaseFirestore.instance
        .collection('Users').doc(email).collection("Posts")
        .doc(ola.toString()).update({"likes":FieldValue.arrayRemove([username])});
}

}
