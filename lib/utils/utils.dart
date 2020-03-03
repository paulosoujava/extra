import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extra/utils/colors.dart';
import 'package:extra/utils/consts.dart';
import 'package:extra/utils/prefs.dart';
import 'package:extra/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

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

  push(context, Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return page;
    }));
  }

  pushNoReplacement(context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return page;
    }));
  }

  errorFirebase(String type) {
    if (type.contains('ERROR_WEAK_PASSWORD'))
      return Strings.ERROR_WEAK_PASSWORD;
    else if (type.contains("ERROR_EMAIL_ALREADY_IN_USE"))
      return Strings.ERROR_EMAIL_ALREADY_IN_USE;
    else if (type.contains("ERROR_USER_NOT_FOUND"))
      return Strings.ERROR_USER_NOT_FOUND;
    else if (type.contains("ERROR_TOO_MANY_REQUESTS"))
      return Strings.ERROR_TOO_MANY_REQUESTS;
    else if (type.contains("ERROR_WRONG_PASSWORD"))
      return Strings.ERROR_WRONG_PASSWORD;
    else
      return Strings.ERROR_DEFAULT;
  }
  toast(String msg, BuildContext context){
    Toast.show(msg, context, duration: Toast.LENGTH_SHORT, gravity:  Toast.CENTER);

  }

  basicAlert(context, String positiveText, String titleText, String contentText,
      {bool isBack = false, Widget page}) {
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
            if (isBack) Utils().push(context, page);
          },
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.easeInCirc,
      duration: Duration(seconds: 1),
    );
  }

  header(context) {
    return
      Row(
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

  title(context, String action, {double t1, double t2, double t3}) {
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
                fontSize: t2 ?? 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Text(
              "]",
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: t3 ?? 30,
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

  allDataProfileOk() async {
    int x = await Prefs.getInt(Consts.ALL_DATA_PROFILE_OK);
    if (x == 2) return;
    Prefs.setInt(Consts.ALL_DATA_PROFILE_OK, 1);
  }

  String replace(String pathPhoto) {
    String o = pathPhoto.replaceAll('File:', '');
    return o.replaceAll("'", "").trim();
  }

  roundedImage(String url, {double h = 82, double w = 82}) {
    return ClipOval(
      child: Container(
        color: MyColors.PRIMARY_COLOR,
        height: h,
        width: w,
        child: CachedNetworkImage(
          placeholder: (context, url) => CircularProgressIndicator(backgroundColor: Colors.white,),
          errorWidget: (context, url, error) => Icon(Icons.error),
          imageUrl: url,
          width: w,
          height: h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
  roundedImageFile(String url){
    return  Container(
      width: 82,
      height: 82,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: FileImage(File(Utils().replace(url)) ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(Radius.circular(90.0)),
        border: Border.all(
          color: MyColors.PRIMARY_COLOR,
          width: 1.0,
        ),
      ),
    );
  }

}
