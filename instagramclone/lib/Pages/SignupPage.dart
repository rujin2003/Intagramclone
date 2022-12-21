import 'package:flutter/material.dart';
import 'package:instagramclone/LoginSignup.dart';
import 'package:get/get.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool showpass=false;
TextEditingController email=TextEditingController();
TextEditingController password=TextEditingController();
TextEditingController username=TextEditingController();
TextEditingController fullname = TextEditingController();
Userentry signin = Userentry();
bool sign=false;
  @override
  Widget build(BuildContext context) {
    return sign==false? Scaffold(
      backgroundColor: Colors.transparent,
      body:  Stack(
        children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(width: MediaQuery.of(context).size.width,height: MediaQuery.of(context).size.height,decoration: const BoxDecoration(image:DecorationImage(image: AssetImage("images/background.jpg"),fit: BoxFit.cover)),)),
        Column(
            children: [
              const SizedBox(height: 70,),
              Center(
                child: Container(
                  width: 200,
                  height: 150,
                  child: const Image(image:AssetImage("images/instagram.png"),fit: BoxFit.contain,),),

              ),
              const SizedBox(height: 30,),
              Container(
                height: 400,
                width: 280,

               decoration: BoxDecoration(borderRadius:BorderRadius.circular(15),color: Colors.white), 
                child: Column(
                  children: [
                    const SizedBox(height: 18,),
                    Container(
                      width: double.infinity,
                      height: 45,
                       decoration: BoxDecoration(borderRadius:BorderRadius.circular(25),color: Colors.white10), 
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: email,
                          decoration: const InputDecoration(
                        
                          filled:true, hintText: "Email",hintStyle: TextStyle(fontSize:14)),),
                      )),
                      const SizedBox(height: 18,),
                      Container(
                      width: double.infinity,
                      height: 45,
                       decoration: BoxDecoration(borderRadius:BorderRadius.circular(25),color: Colors.white10), 
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: fullname,
                          decoration: const InputDecoration(
                        
                          filled:true, hintText: "Full name",hintStyle: TextStyle(fontSize:14)),),
                      )),
                       const SizedBox(height: 18,),
                      Container(
                      width: double.infinity,
                      height: 45,
                       decoration: BoxDecoration(borderRadius:BorderRadius.circular(25),color: Colors.white10), 
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: username,
                          decoration: const InputDecoration(
                        
                          filled:true, hintText: "Username",hintStyle: TextStyle(fontSize:14)),),
                      )),
                      const SizedBox(height: 10,),
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
                            
                          filled:true,hintText: "password",hintStyle: const TextStyle(fontSize:14)),
                          obscureText:showpass==false? true : false
                          ,),

                      )),
                    
                        const SizedBox(height: 10,),

                           ElevatedButton(onPressed:() {
                            setState(() {
                              sign=true;
                            });
                             signin.userSignup(email.text.trim(), password.text.trim(), username.text.trim(), fullname.text.trim(), context);
                           }, child: Container(
                          height: 30,
                          width: 150,
                          decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
                          child: const Center(child: Text("Signup")),

                        )
 
                           ),
                           const SizedBox(height: 10,),
                           Stack(children:[ const Divider(color: Colors.black,),
                           const Center(child: Text('OR'))
                         
                           ]),
                           const SizedBox(height: 20,),

                           Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Container(
                              height: 20,
                              width: 20,
                              child: const Image(image: AssetImage('images/facebook.png'),fit: BoxFit.contain,),),
                            const Text("Countinue with Facebook",style: TextStyle(color: Colors.blue,fontSize: 13),)
                           ],)

                           

                       
                  ],
                ),)
            ],
          ),
    ]  ),
      
    ): Container(child: Center(child: CircularProgressIndicator()),);
  }
}