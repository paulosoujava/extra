import 'package:extra/utils/colors.dart';
import 'package:extra/utils/strings.dart';
import 'package:extra/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class Loading extends StatefulWidget {
  bool hasSizeTitle;
  double sizeLoading;
  double sizeTitle1;
  double sizeTitle2;
  double sizeTitle3;
  double sizeHeight;
  double sizeWidth;

  Loading(
      {this.sizeLoading,
      this.sizeTitle1,
      this.sizeTitle2,
      this.sizeTitle3,
      this.hasSizeTitle = false,
      this.sizeHeight = 0,
        this.sizeWidth = 0});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  
  @override
  Widget build(BuildContext context) {

    sizeScreem(context);
    
    
    return Container(
      height: widget.sizeHeight ,
      width: widget.sizeWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (widget.hasSizeTitle)
            Utils().title(
              context,
              Strings.CONNECTED,
              t1: widget.sizeTitle1,
              t2: widget.sizeTitle2,
              t3: widget.sizeTitle3,
            )
          else
            Utils().title(context, Strings.CONNECTED),
          LoadingBouncingLine.circle(
            borderColor: Colors.white,
            backgroundColor: MyColors.ACCENT_COLOR,
            size: widget.sizeLoading ?? 35,
          ),
        ],
      ),
    );
  }

  void sizeScreem(BuildContext context) {
      if( widget.sizeWidth == 0 ){
      widget.sizeWidth = MediaQuery.of(context).size.width;  
    }
    if( widget.sizeHeight == 0 ){
      widget.sizeHeight = MediaQuery.of(context).size.height;
    }
  }
}
