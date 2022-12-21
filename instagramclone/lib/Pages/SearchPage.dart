import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:instagramclone/Pages/Functions.dart';
import 'package:instagramclone/Pages/ProfilePage.dart';
import 'package:instagramclone/Pages/Userprofilepage.dart';
import 'package:provider/provider.dart';

class Searchpage extends StatefulWidget {
  const Searchpage({super.key});

  @override
  State<Searchpage> createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  TextEditingController searchcontroller =TextEditingController();
  bool search=false;
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(child: Column(
      
     children: [
      
      SizedBox(height: 30,),
      Center(
        child: Container(
         decoration: BoxDecoration(color: Colors.white54,borderRadius: BorderRadius.circular(15),border: Border.all()),

        width: 350,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextField(
              controller: searchcontroller,
              decoration: InputDecoration(
                
                 border: InputBorder.none,
                hintText: 'Search.....',suffixIcon: Container(

                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [IconButton(onPressed: (() async{

                  if(searchcontroller!=null && searchcontroller!=Provider.of<Functions>(context,listen: false).userProfile["username"]){
                    setState(() {
                      search=true;
                    });
                    Future.delayed(Duration(seconds: 3), (){
                        setState(() {
                      search=false;
                    });
                       });

                   await Provider.of<Functions>(context,listen: false).Searchfunction(searchcontroller.text);
                   searchcontroller.clear();

                  }
                }), icon: Icon(Icons.search))],)
              ), 
          
    ),),
        ),),
     ),

   Provider.of<Functions>(context).searchedUser != null ? 
  
   
   searched(Provider.of<Functions>(context).searchedUser!["username"],Provider.of<Functions>(context).searchedUser!["profilepc"],context): 
   
   search==false? Container(child: Text(""),):Container(
     margin:EdgeInsets.all(50), child: Center(child: CircularProgressIndicator()),)
    ],
    ));
  }
  Widget searched(username,image,context){
  return InkWell(
    onTap: (() async{
      await Provider.of<Functions>(context,listen: false).followercheck(Provider.of<Functions>(context,listen: false).searchedUser!["email"]);
      Get.to(userProfile(
        email:Provider.of<Functions>(context,listen: false).searchedUser!["email"] ,
        username:Provider.of<Functions>(context,listen: false).searchedUser!["username"],
       profilepc: Provider.of<Functions>(context,listen: false).searchedUser!["profilepc"],
        bio:Provider.of<Functions>(context,listen: false).searchedUser!["bio"],
        fullname: Provider.of<Functions>(context,listen: false).searchedUser!["fullname"],
         follower: Provider.of<Functions>(context,listen: false).searchedUser!["follower"].toString(), 
         following:Provider.of<Functions>(context,listen: false).searchedUser!["following"].toString(), 
         posts: Provider.of<Functions>(context,listen: false).searchedUser!["posts"].toString()));

         
     
    setState(() {
      search=false;
    });
    
    }),
     child: Container(
      
      margin: EdgeInsets.only(top: 30,left: 10,right: 10),
      width: double.infinity,height: 60,decoration: BoxDecoration(
        boxShadow:[ 
                 BoxShadow(
                    color: Colors.grey.withOpacity(0.5), //color of shadow
                    spreadRadius: 5, //spread radius
                    blurRadius: 7, // blur radius
                    offset: Offset(0, 2), // changes position of shadow
                    //first paramerter of offset is left-right
                    //second parameter is top to down
                 ),
                 //you can set more BoxShadow() here
                ],
        color: Colors.white,borderRadius: BorderRadius.circular(15)),
      child: Row(children: [
        SizedBox(width: 10,),
        image!="none"?
                       Container(height: 45,
                      width: 45,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25) ,image: DecorationImage(image: NetworkImage(image),fit: BoxFit.cover,),color: Colors.purple),
                      ):Container(height: 45,
                      width: 45,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(25) ,color: Colors.purple)),
   SizedBox(width: 30,),
              Text(username,style: TextStyle(fontWeight: FontWeight.bold),)
      ],)
     ),
   );
}
}
