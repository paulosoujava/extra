import 'package:extra/pages/welcome/welcome.dart';
import 'package:extra/entity/extra_job.dart';
import 'package:extra/utils/colors.dart';
import 'package:extra/utils/event_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<EventBus>(
            builder: (context) => EventBus(),
            dispose: (c, b) => b.dispose(),
          )
        ],
        child: MaterialApp(
          title: 'Extra',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // Define the default brightness and colors.
            brightness: Brightness.light,
            primaryColor: MyColors.PRIMARY_COLOR,
            accentColor: MyColors.ACCENT_COLOR,
            fontFamily: 'Tahoma',
          ),
          home: Welcome(),
        ));
  }
}
