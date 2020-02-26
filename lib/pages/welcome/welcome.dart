import 'package:extra/pages/home.dart';
import 'package:extra/pages/welcome/home_welcome.dart';
import 'package:extra/pages/welcome/login.dart';
import 'package:extra/pages/welcome/register.dart';
import 'package:extra/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:nice_button/nice_button.dart';

class Welcome extends StatefulWidget {
  bool isGoogleLogin = false;

  @override
  _WelcomeState createState() => _WelcomeState();


}

class _WelcomeState extends State<Welcome> {
  PageController _pageCtrl;


  @override
  void initState() {
    super.initState();
    _pageCtrl = PageController(initialPage: 1);
    isLoggedFirebase();
    print("HERE CALL ME ");
  }

  void isLoggedFirebase() {
    Future<FirebaseUser> result = FirebaseAuth.instance.currentUser();
    result.then((user){
      if( user != null)
      Utils().push(context, Home(), replace: true);
    });
  }

  @override
  Widget build(BuildContext context) {

    isLoggedFirebase();

    return SafeArea(
        child: Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        child: PageView(
          controller: _pageCtrl,
          children: <Widget>[
            Register( isScroable:  true),
            HomeWelcome(),
            Login(isScroable:  true),
          ],
        ),
      ),
    ));
  }
}
