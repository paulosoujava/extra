import 'package:extra/pages/home.dart';
import 'package:extra/pages/welcome/login.dart';
import 'package:extra/pages/welcome/register.dart';
import 'package:extra/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:nice_button/nice_button.dart';

class HomeWelcome extends StatefulWidget {
  @override
  _HomeWelcomeState createState() => _HomeWelcomeState();
}

class _HomeWelcomeState extends State<HomeWelcome> {
  bool isGoogleLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _content()
          ),
        ),
      ),
    );
  }

  _content() {
    return Column(
      children: <Widget>[
        Consts().header(context),
        SizedBox(
          height: 30,
        ),
        _signButton("Login", 1),
        SizedBox(
          height: 30,
        ),
        _signButton("Novo usuário", 2),
        SizedBox(
          height: 30,
        ),
        _signButton("Login com o Google", 3),
        SizedBox(
          height: 30,
        ),
        Text("vs: 0.0.1")
      ],
    );
  }

  _signButton(String title, int whereIGo) {
    return Stack(
      children: <Widget>[
        NiceButton(
          elevation: 8,
          radius: 10,
          gradientColors: [Consts.PRIMARY_COLOR, Consts.ACCENT_COLOR],
          text: isGoogleLogin ? "" : title,
          onPressed: () {
            switch (whereIGo) {
              case 1:
                Consts().push(context, Login(isScroable: false, ));
                break;
              case 2:
                Consts().push(context, Register( isScroable: false,));
                break;
              case 3:
                Consts().push(context, Home( ));
                break;
            }
          },
        ),
        isGoogleLogin
            ? Center(
                child: LoadingBouncingLine.circle(
                  borderColor: Colors.green,
                  backgroundColor: Colors.white,
                  size: 50.0,
                ),
              )
            : Container()
      ],
    );
  }
}
