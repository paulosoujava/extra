import 'package:extra/utils/colors.dart';
import 'package:extra/utils/strings.dart';
import 'package:extra/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoHasData extends StatelessWidget {

  String title;


  NoHasData(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Utils().title(context, Strings.OPS, t1: 15, t2: 15, t3: 15),
            Divider(
              color: MyColors.PRIMARY_COLOR,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Text(title),
              ),
            ),
          ],
        ),
      ),
    );
  }
}