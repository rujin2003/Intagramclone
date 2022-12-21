

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:instagramclone/Pages/LoginPage.dart';
import 'package:instagramclone/Pages/Posts.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Functions.dart';

class Profile extends StatefulWidget {

  
 Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

addbio(context,TextEditingController bio){

   showDialog(context: context, builder: ((context) {
     return AlertDialog(title:const Text("Error!"),
     content: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
      height: 100,width: 100,child: Column(
      children:  [const Expanded(child: SizedBox(height: 10,)),
        Container(
                      width: double.infinity,
                      height: 50,
                       decoration: BoxDecoration(borderRadius:BorderRadius.circular(25),color: Colors.white10), 
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: bio,
                          decoration: const InputDecoration(
                        
                          filled:true, hintText: "Your bio....",hintStyle: TextStyle(fontSize:14)),),
                      )),
        const Expanded(child: SizedBox()),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
          ElevatedButton(onPressed: (()async {
          await  Provider.of<Functions>(context,listen:false ).addbio(bio.text);
          bio.clear();
             Navigator.of(context).pop();
          }), child:const Text("add"),
         ) ],)


      ],
     ),),
     );
   }));
}

addbioAndEdit(value,TextEditingController bio,context){
switch(value){
  case 0: addbio(context,bio);
    break;
  case 1: print("kola");
     break;
  
}
}



class _ProfileState extends State<Profile> {
  File? image;

Future pickimage(ImageSource source)async{
  try {
    final image = await ImagePicker().pickImage(source: source);
final imageP= File(image!.path);
setState(() {
  this.image = imageP;
});
  } catch (e) {
    print(e.toString());
  }

}


TextEditingController bio =TextEditingController();
  bool bioOption=true;
  @override
  Widget build(BuildContext context) {
  
    return SafeArea(
      child: Column(
        children: [
        Row(
          mainAxisAlignment:MainAxisAlignment.start,
          children: [
            const SizedBox(width: 50,),
            Text(Provider.of<Functions>(context).userProfile['username'],style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)],),


            const SizedBox(height: 30,),

           //Post followers and following section
          Row(children: [
            const SizedBox(width: 30,),
            Column(
              children: [
        
           Provider.of<Functions>(context).userProfile['profilepc']==null || Provider.of<Functions>(context).userProfile['profilepc']=="none"?
           image==null?  
           GestureDetector(
                onTap:(() =>  pickimage(ImageSource.gallery)),
                child: Container(
                    margin: const EdgeInsets.only(bottom:5),
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(36),color: const Color.fromRGBO(165, 105, 189, 100),image: const DecorationImage(image: AssetImage("images/profile.png")))),
              ):GestureDetector(
                onTap: (() {
                  Provider.of<Functions>(context,listen: false).addProfileimg(image);
                }),
                child: Container(
                       height: 70,
                      width: 70,
                      
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent,width: 3),
                        borderRadius: BorderRadius.circular(36) ,image: DecorationImage(image: FileImage(image!,),fit: BoxFit.cover)),
                      ),
              ):
                    
                Container(
                     height: 70,
                    width: 70,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(36) ,image: DecorationImage(image: NetworkImage( Provider.of<Functions>(context).userProfile['profilepc']),fit: BoxFit.cover)),
                    ),
                

                  //add boi option edit usename option in the correspongind row 
                  SizedBox(height: 8,),
                  PopupMenuButton(
                    child: Text(Provider.of<Functions>(context).userProfile['fullname'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize:16)),
                    itemBuilder: ((context) => [
                   PopupMenuItem(child: Row(
                     children: [
                       const Text(" Add Bio"),
                       const Icon(Icons.add)
                     ],
                   ),value: 0,),
                  PopupMenuItem(child: Row(
                    children: [
                      const Text("Edit Username"),
                      const Icon(Icons.edit)
                    ],
                  ),value: 1,)
                                     
                  ]
                  ),onSelected: ((value) => addbioAndEdit(value,bio,context))
                                   ),
                  
              ],
            ),
            const SizedBox(width: 40,),

            Column(
              children: [
                Row(children: [Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Text(Provider.of<Functions>(context).userProfile['posts'].toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    const Text("Posts")
                  ],),
                    const SizedBox(width: 15,),
                    Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Text(Provider.of<Functions>(context).userProfile['follower'].toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    const Text("Followers"),
                  ],),
                    const SizedBox(width: 15,),
                   Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    Text(Provider.of<Functions>(context).userProfile['following'].toString(),style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    const Text("Following"),
                  ],)],),
                  const SizedBox(height: 7,),
                    Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            ButtonTheme(
                minWidth: 150,
  height: 20,
              child: ElevatedButton(
                
                onPressed: (() async{
               Provider.of<Functions>(context,listen: false).userProfile={};
               await FirebaseAuth.instance.signOut();
               Get.to(const Login());
              }),child:Container(
                width: 100,
                height: 20,
                child: const Center(child: Text("Signout"),),)),
            ),
              ],)
              ],
            ),

            
              
          ],),
            const SizedBox(height: 4,),
          Row(children: [
              const SizedBox(width: 10,),
       Text(Provider.of<Functions>(context).userProfile['bio'] ?? "")],),

       const SizedBox(height: 30,),
        Posts(email: FirebaseAuth.instance.currentUser!.email??"",)
        
          
      ],),
    );
  }
}