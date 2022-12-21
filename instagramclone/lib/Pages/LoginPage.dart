import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:instagramclone/LoginSignup.dart';
import 'package:instagramclone/Pages/SignupPage.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Homepage.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
bool log=false;
bool showpass=false;
TextEditingController email=TextEditingController();
TextEditingController password=TextEditingController();
Userentry login = Userentry();
  @override
  Widget build(BuildContext context) {
    return log == false ?Scaffold(
      backgroundColor: Colors.transparent,
      body:  Stack(
        children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,decoration: BoxDecoration(image:DecorationImage(image: AssetImage("images/background.jpg"),fit: BoxFit.cover)),)),
        Column(
            children: [
              SizedBox(height: 70,),
              Center(
                child: Container(
                  width: 200,
                  height: 150,
                  child: Image(image:AssetImage("images/instagram.png"),fit: BoxFit.contain,),),

              ),
              SizedBox(height: 30,),
              Container(
                height: 400,
                width: 280,

               decoration: BoxDecoration(borderRadius:BorderRadius.circular(15),color: Colors.white), 
                child: Column(
                  children: [
                    SizedBox(height: 80,),
                    Container(
                      width: double.infinity,
                      height: 50,
                       decoration: BoxDecoration(borderRadius:BorderRadius.circular(25),color: Colors.white10), 
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: email,
                          decoration: InputDecoration(
                        
                          filled:true, hintText: "Phone number,username or email",hintStyle: TextStyle(fontSize:14)),),
                      )),
                      SizedBox(height: 20,),
                       Container(
                      width: double.infinity,
                      height: 50,
                       decoration: BoxDecoration(borderRadius:BorderRadius.circular(25),color: Colors.white10), 
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                        controller: password,
                          decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon:const  Icon(Icons.crisis_alert,size: 20,),
                            onPressed: (){
                                 setState(() {
                                  if(showpass==false){
                                     setState(() {
                                       showpass=true;
                                     });
                                  }else {
                                    setState(() {
                                      showpass=false;
                                    });
                                  }
                                   
                                 });
                            },
                            ),
                            
                          filled:true,hintText: "Password",hintStyle: TextStyle(fontSize:14)),
                          obscureText:showpass==false? true : false
                          ,),

                      )),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text("Forgot password?",style: TextStyle(color: Colors.blue,fontSize: 11),)),
                        SizedBox(height: 20,),


                           ElevatedButton(onPressed:() {
                            login.userLogin(email.text.trim(),password.text.trim(),context);
                          
                                        setState(() {
                              log=true;

                            }
                        );
                       
                            Future.delayed(Duration(seconds: 3), (){
                        setState(() {
                      log=false;
                    });
                       });
                          
                            

                           }, child: Container(
                          height: 30,
                          width: 150,
                          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
                          child: Center(child: Text("Login")),

                        )

                           ),
                           SizedBox(height: 10,),
                           Stack(children:const [ Divider(color: Colors.black,),
                           Center(child: Text('OR'))
                         
                           ]),
                           SizedBox(height: 20,),

                           Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: Image(image: AssetImage('images/facebook.png'),fit: BoxFit.contain,),),

                            Text("Countinue with Facebook /",style: TextStyle(color: Colors.blue,fontSize: 13),),
                               GestureDetector(
                                onTap: () => Get.to(Signup()),
                                child: Text(" signin",style: TextStyle(color: Colors.blue,fontSize: 13),) ,)
                           ],)

                           

                       
                  ],
                ),)
            ],
          ),
    ]  ),
      
    ):Container(child: Center(child: CircularProgressIndicator(),),);
  }
}