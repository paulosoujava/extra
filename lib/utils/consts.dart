import 'package:bubble/bubble.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class Consts {
  static final double MY_WIDHT_CARD = 250;
  static final String REDE = "rede";
  static final String ANNONCEMENT = "Anúncio";
  static final String CONVERSATION = "Conversa";
  static final Color PRIMARY_COLOR = Hexcolor("#075E54");
  static final Color ACCENT_COLOR = Hexcolor("#128C7E");

//  push(context, Widget page) {
//    return Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => page),
//    );
//  }

  push(context, Widget page){
    Navigator.of(context).push(_createRoute(page));
}


  Route _createRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
  header(context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text("E",
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        Text("X",
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 38,
            fontWeight: FontWeight.w700,
            color: Consts.PRIMARY_COLOR,
          ),
        ),
        Text("tra",
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

  title(context,  String action){
    return  Column(
      children: <Widget>[
        header(context),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("[",
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: PRIMARY_COLOR,
              ),
            ),
            Text("$action",
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Text("]",
              style: GoogleFonts.portLligatSans(
                textStyle: Theme.of(context).textTheme.display1,
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: PRIMARY_COLOR,
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
