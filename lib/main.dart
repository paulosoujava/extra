import 'package:extra/pages/welcome/welcome.dart';
import 'package:extra/utils/colors.dart';
import 'package:extra/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: MyColors.PRIMARY_COLOR,
        accentColor: MyColors.ACCENT_COLOR,
        fontFamily: 'Tahoma',
      ),
      home: Welcome(),
    );
  }

}
