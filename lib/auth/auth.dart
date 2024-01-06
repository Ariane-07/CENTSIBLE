import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/auth/login_or_register.dart';
import 'package:groceryapp/pages/intro_page.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          // user is logged in
          if (snapshot.hasData){
            return const IntroPage();
          }
          // user in not loggeed in
          else{
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}