import 'package:extra/api/api_response.dart';
import 'package:extra/bloc/register_bloc.dart';
import 'package:extra/pages/about.dart';
import 'package:extra/pages/home.dart';
import 'package:extra/pages/terms.dart';
import 'package:extra/pages/welcome/login.dart';
import 'package:extra/pages/welcome/register.dart';
import 'package:extra/service/firebase_service.dart';
import 'package:extra/utils/colors.dart';
import 'package:extra/utils/consts.dart';
import 'package:extra/utils/prefs.dart';
import 'package:extra/utils/strings.dart';
import 'package:extra/utils/utils.dart';
import 'package:extra/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:nice_button/nice_button.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool isGoogleLogin = false;
  WelcomeBloc bloc = WelcomeBloc();

@override
  void initState() {
    _checkUser();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body:
      Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: isGoogleLogin
            ? Loading(
          sizeTitle2: 14,
          sizeTitle1: 14,
          sizeTitle3: 14,
          hasSizeTitle: true,
        )
            : SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(8.0), child: _content()),
        ),
      ),
    );
  }

  _content() {
    return Column(
      children: <Widget>[
        Utils().title(context, Strings.WELCOME, t1: 15, t2: 15, t3: 15),
        SizedBox(
          height: 30,
        ),
        _signButton(Strings.LOGIN, 1),
        SizedBox(
          height: 30,
        ),
        _signButton(Strings.NEW_USER, 2),
        SizedBox(
          height: 30,
        ),
        _signButton(Strings.WITH_GOOGLE, 3),
        SizedBox(
          height: 30,
        ),
        Container(
          alignment: Alignment.center,
          width: 200,
          child: InkWell(
            onTap: () {
              Utils().push(context, Terms());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(Strings.TERMS_AND_RESPONSABILITY),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: 200,
          child: InkWell(
            onTap: () {
              Utils().push(context, About());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(Strings.ABOUT),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),

      ],
    );
  }

  _signButton(String title, int whereIGo) {
    return Stack(
      children: <Widget>[
        NiceButton(
          elevation: 16,
          radius: 10,
          gradientColors: [MyColors.PRIMARY_COLOR, MyColors.ACCENT_COLOR],
          text:  title,
          onPressed: () async {
            switch (whereIGo) {
              case 1:
                Utils().push(
                    context,
                    Login(),
                );
                break;
              case 2:
                Utils().push(
                    context,
                    Register(),
                );
                break;
              case 3:
                if (await Prefs.getBool(Consts.ACCEPT_TERMS)) {
                  setState(() {
                    isGoogleLogin = true;
                  });
                  _doLogin();
                } else {
                  _alert(context);
                }

                break;
            }
          },
        ),
      ],
    );
  }

   _alert(context) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          negativeText: Strings.NO,
          positiveText: Strings.YES_I_ACCEPT,
          titleText: Strings.TERMS_AND_RESPONSABILITY,
          contentText: Strings.TEXT_DIALOG,
          onPositiveClick: () async {
            setState(() {
              isGoogleLogin = true;
            });
            Navigator.of(context).pop();
          _doLogin();
            //Utils().push(context, Home(), replace: true);
          },
          onNegativeClick: () {
            Navigator.of(context).pop();
          },
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.ease,
      duration: Duration(seconds: 0),
    );
  }

   _gotTO(String name) {
    Utils().push(context, Home(nameFromLoginWithGoogle: name,));
  }

   _doLogin() async {
    ApiResponse response = await bloc.loginGoogle();
    if (response.ok) {
      //só fica 2 quando todos os dados forem setados
      Utils().allDataProfileOk();
      //acceptTerms
      Prefs.setBool(Consts.ACCEPT_TERMS, true);
      setState(() {
        isGoogleLogin = false;
        _gotTO(response.result);
      });
    } else {
      setState(() {
        isGoogleLogin = false;
      });
      Utils().basicAlert(context, Strings.OK_I_UNDERSTAND, Strings.OPS,
          "${response.msg}");
    }
  }

  void _checkUser() {
    Future<FirebaseUser> result = FirebaseAuth.instance.currentUser();
    result.then((user){
      if( user != null){
        setState(() {
          isGoogleLogin = true;
        });
        Utils().push(context, Home());
      }
    });
  }
}
