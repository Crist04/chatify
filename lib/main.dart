import 'package:chatify/screens/chat_screen.dart';
import 'package:chatify/screens/login_screen.dart';
import 'package:chatify/screens/registration_screen.dart';
import 'package:chatify/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black54),
          
        ),
      ),
      //home: WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes:{
        WelcomeScreen.id:(context) => WelcomeScreen(),
        LoginScreen.id:(context) => LoginScreen(),
        RegistrationScreen.id:(context) => RegistrationScreen(),
        ChatScreen.id:(context) => ChatScreen()

      } ,
    );
  }
}
