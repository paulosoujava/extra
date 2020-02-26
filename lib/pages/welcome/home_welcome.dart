import 'package:extra/pages/home.dart';
import 'package:extra/pages/terms.dart';
import 'package:extra/pages/welcome/login.dart';
import 'package:extra/pages/welcome/register.dart';
import 'package:extra/utils/colors.dart';
import 'package:extra/utils/strings.dart';
import 'package:extra/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:nice_button/nice_button.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

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
          child: Padding(padding: const EdgeInsets.all(8.0), child: _content()),
        ),
      ),
    );
  }

  _content() {
    return Column(
      children: <Widget>[
        Utils().header(context),
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
        InkWell(
          onTap: () {
            Utils().push(context, Terms());
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(Strings.TERMS_AND_RESPONSABILITY),
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
          text: isGoogleLogin ? "" : title,
          onPressed: () {
            switch (whereIGo) {
              case 1:
                Utils().push(
                    context,
                    Login(
                      isScroable: false,
                    ));
                break;
              case 2:
                Utils().push(
                    context,
                    Register(
                      isScroable: false,
                    ));
                break;
              case 3:
                _alert(context);
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

  void _alert(context) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          negativeText: Strings.NO,
          positiveText: Strings.YES_I_ACCEPT,
          titleText: Strings.TERMS_AND_RESPONSABILITY,
          contentText:
            Strings.TEXT_DIALOG,
          onPositiveClick: () {
            Navigator.of(context).pop();
            Utils().push(context, Home(), replace: true);
          },
          onNegativeClick: () {
            Navigator.of(context).pop();
          },
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.ease,
      duration: Duration(seconds: 1),
    );
  }
}
