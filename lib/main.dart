import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_e1/models/ai_sample.dart';
import 'package:firebase_e1/screens/chat_screen.dart';
import 'package:firebase_e1/screens/login_screen.dart';
import 'package:firebase_e1/screens/register_screen.dart';

import 'package:flutter/material.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAMUJc4jmk8X_3DkFUDGPz66uFt-E_2T4Q" ,
          appId: "1:266789591562:android:2bcea1a67d8285dafc9df3" ,
          messagingSenderId:"266789591562",
          projectId: "fir-project-5ec4b"
      )
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      routes:  {
        LoginScreen.id : (context) => LoginScreen(),
        RegisterScreen.id : (context) => const RegisterScreen(),
        ChatScreen.id : (context) => ChatScreen(),
        //'MyHomePage' : (context) => MyHomePage() ,
      },
      initialRoute: LoginScreen.id ,
    ) ;
  }
}


