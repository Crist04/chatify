import 'package:chatify/components/buttonComponent.dart';
import 'package:chatify/constants.dart';
import 'package:chatify/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner=false;
  late String Email;
  late String Password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                style: kInputTextStyle,
                  onChanged: (value) {
                    Email = value;
                  },
                  decoration: kInputTextFieldDecoration.copyWith(
                      hintText: 'Enter Your Email')),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                
                style: kInputTextStyle,
                  onChanged: (value) {
                    Password=value;
                  },
                  decoration: kInputTextFieldDecoration.copyWith(
                      hintText: 'Enter your Password')),
              SizedBox(
                height: 24.0,
              ),
              ButtonComponent(
                buttonColor: Colors.blueAccent,
                buttonText: 'Login',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try{
                    final user = await _auth.signInWithEmailAndPassword(email: Email, password: Password);
      
                  if(user != null)
                  {
                    Navigator.pushNamed(context, ChatScreen.id);
                  }
                  setState(() {
                    showSpinner = false;
                  });
                  }
                  catch(e)
                  {
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
