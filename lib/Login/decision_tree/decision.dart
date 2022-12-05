import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/Login/main.dart';
import 'package:login_page/Screen/Homepage.dart';

class decision extends StatefulWidget {
  const decision({Key? key}) : super(key: key);

  @override
  State<decision> createState() => _decisionState();
}

class _decisionState extends State<decision> {
  User? user;
  @override
  void initState() {
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
  }
  onRefresh(userCred){
    setState((){
      user=userCred;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(user==null){
      return LoginPage();
    }
    return homepage(
      onsignout: (userCred)=>onRefresh(userCred),
    );
  }
}
