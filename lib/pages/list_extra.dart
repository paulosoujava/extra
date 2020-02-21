import 'package:extra/pages/extra.dart';
import 'package:extra/utils/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:extra/widgets/card_item_extra.dart';

class ListExtras extends StatefulWidget {
  @override
  _ListExtrasState createState() => _ListExtrasState();
}

class _ListExtrasState extends State<ListExtras> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Extras"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              Consts().push(context, Extra());
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[

            CardItemExtra("Descrição Descrição Descrição Descrição v Descrição Descrição Descrição "
                "DescriçãoDescrição Descrição v Descrição vvv v v vv DescriçãoDescriçãoDescrição"
                "DescriçãoDescriçãoDescriçãoDescriçãoDescriçãoDescrição",
            ),
          ],
        ),
      ),
    );
  }

}
