import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:instagramclone/Pages/Functions.dart';
import 'package:provider/provider.dart';


class HomepagePosts extends StatefulWidget {
  final String postImage;
  final String username;
  final String profilepc;
  final String caption;
  final bool liked;
  final String email;
  final int index;
  




  const HomepagePosts({super.key, required this.postImage, required this.username, required this.profilepc, required this.caption, required this.liked, required this.email, required this.index});

  @override
  State<HomepagePosts> createState() => _HomepagePostsState();
}

class _HomepagePostsState extends State<HomepagePosts> {

late bool likeed;


    @override
void initState() {
  super.initState();
likeed = widget.liked;
}

  


  @override
  Widget build(BuildContext context) {
    
     
    return
     Padding(
       padding: const EdgeInsets.all(10),
       child: Container(
        height: 400,width:350,decoration: const BoxDecoration(
        boxShadow: [
        BoxShadow(
          color: Color(0xffDDDDDD),
          blurRadius: 6.0,
          spreadRadius: 2.0,
          offset: Offset(0.0, 0.0),
        )
    ],
        color: Colors.red),
        child: Column(children: [
          Container(
            
            
            width: double.infinity,height: 40,decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
             boxShadow: const [
        BoxShadow(
          color: Color(0xffDDDDDD),
          blurRadius: 6.0,
          spreadRadius: 2.0,
          offset: Offset(0.0, 0.0),
        )
    ],),
    child: Row(children: [
        const SizedBox(width: 7,),
        
        Container(height: 35,width: 35,decoration: BoxDecoration(color: Color.fromRGBO(187, 143, 206  ,100),borderRadius: BorderRadius.circular(17),image: DecorationImage(image: NetworkImage(widget.profilepc),fit: BoxFit.cover)),),
        const SizedBox(width: 5,),
        Text(widget.username,style: TextStyle(fontWeight: FontWeight.w600),)
    ],),
    
    ),


    Container(width: double.infinity,height: 325,decoration: BoxDecoration(color: Color.fromRGBO(204, 204, 255,100),image: DecorationImage(image: NetworkImage(widget.postImage),fit: BoxFit.cover)),),


    Container(
        height: 35,
        width: double.infinity,decoration: const BoxDecoration( 
          color: Colors.white,
          boxShadow: [
        BoxShadow(
          color: Color(0xffDDDDDD),
          blurRadius: 6.0,
          spreadRadius: 2.0,
          offset: Offset(0.0, 0.0),
        )
    ],),
    
    child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(width: 5,),
         
        Container(
         
          width: 230,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(

              widget.caption,style: TextStyle(fontWeight: FontWeight.w600),))),
        Expanded(child: SizedBox()),

       widget.liked==false ?
       IconButton(onPressed: (() {
            Provider.of<Functions>(context,listen: false).likes(Provider.of<Functions>(context,listen: false).userProfile["username"],widget.email,widget.index);
            setState(() {
              likeed=true;
            });
          }), icon:const Icon(Icons.favorite,color: Colors.grey,)): IconButton(onPressed: (() {
           
            
               Provider.of<Functions>(context,listen: false).unlike(Provider.of<Functions>(context,listen: false).userProfile["username"],widget.email,widget.index);
            
        
          }), icon:const Icon(Icons.favorite,color: Colors.red,)),
        IconButton(onPressed: (() {
          showBottomSheet(context: context, builder:((context) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Color.fromRGBO(244, 246, 247  ,100)),
            
            height: 400,
            
            child: Column(children: [
              SizedBox(height: 15,),
            Row(children: [
              SizedBox(width: 5,),
              Text("Comments",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 23),)],),
       SizedBox(height: 5,),
              Container(
            height: 310,
            width: 380,
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Color.fromRGBO(208, 211, 212   ,100)),

                 child: SingleChildScrollView(child: StreamBuilder(builder: ((context, snapshot) {
                  return Container(); 
                 }),)),


              ),
              SizedBox(height: 5,),
              Container(
                 width: 380,
                 height: 30,
decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
color: Colors.white,
 boxShadow: [
      BoxShadow(
        color: Color(0xffDDDDDD),
        blurRadius: 6.0,
        spreadRadius: 2.0,
        offset: Offset(0.0, 0.0),
      )
    ],),
child: Center(
  child: Padding(
    padding: const EdgeInsets.only(left: 10),
    child: TextField(
    decoration: InputDecoration(hintText: "Comment..",border: InputBorder.none),
    ),
  ),
),
                 
           
              )
            ]),
            );
        
          }));
        }), icon:const Icon(Icons.add_comment,color: Color.fromRGBO(187, 143, 206  ,100),)),

    ],),
    ),

        ],),
        
        ),
     );
  }
}