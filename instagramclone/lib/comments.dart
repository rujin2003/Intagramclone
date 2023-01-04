import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Comment extends StatelessWidget {
  final String username;
  final String comment;
  const Comment({super.key, required this.username, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
children: [

  Text(username,style: TextStyle(fontWeight: FontWeight.bold),),
  Text(":"),
  SizedBox(width: 5,),
  Text(comment)
],
      ),
    );
    }
    
    }