import 'package:bubble/bubble.dart';
import 'package:extra/utils/colors.dart';
import 'package:extra/utils/consts.dart';
import 'package:extra/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {
  String validations(int type, String str) {
    switch (type) {
      case Consts.TYPE_EMAIL:
        return _validateEmail(str);

      case Consts.TYPE_TEXT:
        return _validateString(str);
    }
  }

  _validateString(String str) {
    if (str.isEmpty) {
      return Strings.REQUIRED;
    } else {
      return null;
    }
  }

  _validateEmail(String str) {
    if (str.isEmpty) {
      return Strings.OPS_EMAIL;
    } else if (!str.contains("@") || !(str.contains(".com"))) {
      return Strings.EMAIL_INVALID;
    } else {
      return null;
    }
  }

  push(context, Widget page, {replace = false}) {
    replace
        ? Navigator.of(context).pushReplacement(_createRoute(page))
        : Navigator.of(context).push(_createRoute(page));
  }

  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  errorFirebase(String type ){
    if( type.contains('ERROR_WEAK_PASSWORD'))
      return Strings.ERROR_WEAK_PASSWORD;
    else if(type.contains("ERROR_EMAIL_ALREADY_IN_USE"))
      return Strings.ERROR_EMAIL_ALREADY_IN_USE;
    else if(type.contains("ERROR_USER_NOT_FOUND"))
      return Strings.ERROR_USER_NOT_FOUND;

    else
      return Strings.ERROR_DEFAULT;
  }

  basicAlert(
      context, String positiveText, String titleText, String contentText, {bool isBack = false, Widget page}) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          positiveText: positiveText,
          titleText: titleText,
          contentText: contentText,
          onPositiveClick: () {
            Navigator.of(context).pop();
            if( isBack )
              Utils().push(context, page);
          },
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.easeInCirc,
      duration: Duration(seconds: 1),
    );
  }

  header(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "E",
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        Text(
          "X",
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 38,
            fontWeight: FontWeight.w700,
            color: MyColors.PRIMARY_COLOR,
          ),
        ),
        Text(
          "tra",
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  title(context, String action, {double  t1, double  t2, double  t3}) {
    return Column(
      children: <Widget>[
        header(context),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "[",
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: t1 ?? 30,
                fontWeight: FontWeight.w700,
                color: MyColors.PRIMARY_COLOR,
              ),
            ),
            Text(
              "$action",
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize:  t2 ?? 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Text(
              "]",
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize:  t3 ?? 30,
                fontWeight: FontWeight.w700,
                color: MyColors.PRIMARY_COLOR,
              ),
            ),
          ],
        ),
      ],
    );
  }

  styleMe(px) {
    return BubbleStyle(
      nip: BubbleNip.rightTop,
      color: Color.fromARGB(255, 225, 255, 199),
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, left: 50.0),
      alignment: Alignment.topRight,
    );
  }

  styleOther(px) {
    BubbleStyle(
      nip: BubbleNip.leftTop,
      color: Colors.white,
      elevation: 1 * px,
      margin: BubbleEdges.only(top: 8.0, right: 50.0),
      alignment: Alignment.topLeft,
    );
  }

  pixel(context) {
    double pixelRatio = MediaQuery.of(context).devicePixelRatio;
    return 1 / pixelRatio;
  }
}
