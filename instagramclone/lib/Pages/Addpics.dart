import 'dart:io';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagramclone/Pages/Functions.dart';
import 'package:provider/provider.dart';

class Addpost extends StatefulWidget {
  const Addpost({super.key});

  @override
  State<Addpost> createState() => _AddpostState();
}

class _AddpostState extends State<Addpost> {
  File? image;
 bool ola=false;
 bool loading=false;
 TextEditingController caption = TextEditingController();
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
  @override
  Widget build(BuildContext context) {
    return 
    loading==false?
    image==null? Scaffold(
      body: Container(
      
        child: Center(
          child: Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [ 

              PopupMenuButton(
                    itemBuilder: ((context) => [
                   PopupMenuItem(value: 0,child: Row(
                     children: const [
                       Text(" Gallery"),SizedBox(width: 10,),
                       Icon(Icons.add_photo_alternate_rounded )
                     ],
                   ),),
                  PopupMenuItem(value: 1,child: Row(
                    children: const [
                      Text("Camera"),SizedBox(width: 10,),
                      Icon(Icons.add_a_photo_rounded )
                    ],
                  ),)
                                     
                  ]
                  ),onSelected: ((value) {
                    if(value==0){
                      pickimage(ImageSource.gallery);
                    }else{
                      pickimage(ImageSource.camera);
                    }

                  }),
                    child: const Icon(Icons.add,size: 90,)
                                   ),
           
         const  Text("Add Post",style: TextStyle(fontFamily: "satisfy",fontSize: 50,color: Color.fromRGBO(189, 195, 199 ,100)),)
],),
        )
        

       
      ),
    ):Scaffold(
      body: Container(width: double.infinity,height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [IconButton(onPressed: (() {
              setState(() {
                image=null;
              });
            }), icon: const Icon(Icons.cancel,color: Colors.red,size: 30,)),],),
      Container(
        height: 360,
        width: 360,
        
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
        color: Colors.white,boxShadow: const [
       BoxShadow(
        color: Color(0xffDDDDDD),
        blurRadius: 6.0,
        spreadRadius: 2.0,
        offset: Offset(0.0, 0.0),
      ),
      
    ],
    image: DecorationImage(image: FileImage(image!,),fit: BoxFit.cover)
    ),
    child: loading==true? const Center(child: CircularProgressIndicator(),):Container(),
    
    ),
        const SizedBox(height: 40,),
         Container(
        height: 130,
        width: 350,
        
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color:Colors.white, boxShadow: const [
      BoxShadow(
        color: Color(0xffDDDDDD),
        blurRadius: 6.0,
        spreadRadius: 2.0,
        offset: Offset(0.0, 0.0),
      )
    ],),
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child:  TextField(
            controller: caption,
            decoration: InputDecoration(hintText: "Write a caption....",border:InputBorder.none,contentPadding: EdgeInsets.symmetric(vertical: 40.0),)),
        ),
        
        
        ),
       const SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
    shape: const CircleBorder(), //<-- SEE HERE
    
  ),
              onPressed: (() async{
              
                await Provider.of<Functions>(context,listen: false).addposts(image,caption.text.trim());
               
                
          
        }), child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(45),color: const Color.fromRGBO( 142, 68, 173  ,100)),
          child: const Center(child: Icon(Icons.send)))),

          
          ],),

       
       const SizedBox(height: 30,)
        
        ],),
      ),
    ):Container(child: Center(child: CircularProgressIndicator()),);
  }
}