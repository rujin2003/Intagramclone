import 'package:flutter/material.dart';
import 'package:instagramclone/Pages/Homepage.dart';
import 'package:instagramclone/Pages/SearchPage.dart';
import 'Pages/Addpics.dart';
import 'Pages/ProfilePage.dart';


class Mainpages extends StatefulWidget {
  const Mainpages({super.key});

  @override
  State<Mainpages> createState() => _MainpagesState();
}
 int current_index = 0;
  List<Widget> pages= [Homepage(),Searchpage(),Addpost(),Profile()];

class _MainpagesState extends State<Mainpages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: 
       
        IndexedStack(
          index: current_index,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) => setState(() => current_index = index),
          showSelectedLabels: false,
          items:const [BottomNavigationBarItem(icon:Icon(Icons.home,color: Colors.black,size: 30,),label: 'Home',),
          BottomNavigationBarItem(icon:Icon(Icons.search,color: Colors.black,size: 30),label: 'Search',),
           BottomNavigationBarItem(icon:Icon(Icons.add_box,color: Colors.black,size: 30),label: 'addPost',),
             BottomNavigationBarItem(icon:Icon(Icons.contacts,color: Colors.black,size: 30),label: 'Profile',)

          
          ],
        ),
      );
  }
}