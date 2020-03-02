import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extra/entity/profile.dart';
import 'package:extra/pages/public_profile.dart';
import 'package:extra/service/service.dart';
import 'package:extra/utils/colors.dart';
import 'package:extra/utils/strings.dart';
import 'package:extra/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  Profile profile;
  bool type;

  CardItem(this.profile, {this.type = false});

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.type
                ? _itemRede(widget.profile)
                : _itemConversation(widget.profile)),
        Divider(
          color: MyColors.PRIMARY_COLOR,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  Utils().pushNoReplacement(context, PublicProfile());
                },
                icon: Icon(Icons.visibility),
                label: Text(Strings.PROFILE_VIEW)),
            FlatButton.icon(
                onPressed: () {
                  Utils().pushNoReplacement(context, Service().getChats());
                },
                icon: Icon(Icons.chat),
                label: Text(Strings.CHAT_VIEW)),
          ],
        )
      ],
    );
  }

  _itemConversation(profile) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.account_circle,
          size: 64.0,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 200,
                  child: Text(
                    profile.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Container(
                    width: 180,
                    child: Text(
                      "ultimo texto da voncersa",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black45, fontSize: 16.0),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  _itemRede(Profile profile) {
    print(profile);
    return Row(
      children: <Widget>[
        profile.urlPhoto == null
            ? profile.pathPhoto != null
                ? FileImage(File(Utils().replace(profile.pathPhoto)))
                : Icon(
                    Icons.account_circle,
                    size: 64.0,
                  )
            : Utils().roundedImage(profile.urlPhoto),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      profile.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: MyColors.ACCENT_COLOR, shape: BoxShape.circle),
                      alignment: Alignment.center,
                      height: 30,
                      width: 30,
                      child: Text(
                        profile.state.toLowerCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 21.0),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2.0),
                  child: Text(
                    profile.mainFunction,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black45, fontSize: 16.0),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
