import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/button/Button.dart';

class homepage extends StatelessWidget {
  final Function(User?)? onsignout;
  const homepage({this.onsignout});

  Future<void>logout()async{
    await FirebaseAuth.instance.signOut();
    onsignout!(null);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Button(
          width: MediaQuery.of(context).size.width*.3,
          height: MediaQuery.of(context).size.width*.1,
          text: 'Logout',
          on_pressed: (){logout();},
        ),
      ),
    );
  }
}
