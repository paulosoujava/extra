import 'package:extra/utils/colors.dart';
import 'package:extra/utils/strings.dart';
import 'package:extra/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Back extends StatelessWidget {

  Widget page;
  String title;

  Back(this.page, this.title);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 10, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _showBack(page, context),
          Utils().title(context, title),

        ],
      ),
    );
  }

  _showBack(Widget page, BuildContext context) {
    return Row(
      children: <Widget>[
        FlatButton.icon(
          onPressed: () {
            //Navigator.pop(context);
            Utils().push(context, page);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: MyColors.PRIMARY_COLOR,
          ),
          label: Text(
            Strings.BACK,
            style: TextStyle(
              color: MyColors.PRIMARY_COLOR,
            ),
          ),
        ),
      ],
    );
  }
}
