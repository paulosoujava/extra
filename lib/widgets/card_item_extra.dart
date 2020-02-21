import 'package:extra/pages/extra.dart';
import 'package:extra/utils/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardItemExtra extends StatefulWidget {

  String extra;
 bool isAnnoncement;
  CardItemExtra(this.extra, {this.isAnnoncement = false});

  @override
  _CardItemExtraState createState() => _CardItemExtraState();
}

class _CardItemExtraState extends State<CardItemExtra> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "FLorianópolis - SC",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(height: 10,),
            Text(
              widget.extra,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18),
            ),
            Divider(color: Colors.black),
              widget.isAnnoncement ?   _buttons("Perfil","Conversar") : _buttons("Editar","Deletar")

          ],
        ),
      ),
    );
  }

  _buttons( String btn1, String btn2){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton.icon(
            onPressed: () {},
            icon: Icon( widget.isAnnoncement ? Icons.visibility :  Icons.delete),
            label: Text(btn1)),
        FlatButton.icon(
            onPressed: () {
              Consts().push(context, Extra());
            },
            icon: Icon( widget.isAnnoncement ?  Icons.chat : Icons.edit  ),
            label: Text(btn2)),
      ],
    );
  }

}
