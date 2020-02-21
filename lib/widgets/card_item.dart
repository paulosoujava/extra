import 'package:extra/entity/profile.dart';
import 'package:extra/pages/public_profile.dart';
import 'package:extra/service/service.dart';
import 'package:extra/utils/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardItem extends StatefulWidget {
  Profile profile;
  bool type;

  CardItem(this.profile, { this.type = false} );

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
            child: widget.type ? _itemRede(widget.profile) : _itemConversation(widget.profile)

        ),
        Divider(
          color: Consts.PRIMARY_COLOR,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FlatButton.icon(
                onPressed: () {
                  Consts().push(context, PublicProfile(widget.profile));
                },
                icon: Icon(Icons.visibility),
                label: Text("Perfil")),
            FlatButton.icon(
                onPressed: () {
                  Consts().push(context, Service().getChats());
                },
                icon: Icon(Icons.chat),
                label: Text("Chat")),
          ],
        )
      ],
    );
  }


  _itemConversation(profile) {
    return
      Row(
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
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20.0),
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
                    Text(
                      profile.state,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 12.0),
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
