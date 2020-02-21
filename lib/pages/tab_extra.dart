import 'package:extra/widgets/card_item_extra.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class tab_extra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CardItemExtra("Descrição Descrição Descrição Descrição v Descrição Descrição Descrição "
          "DescriçãoDescrição Descrição v Descrição vvv v v vv DescriçãoDescriçãoDescrição"
          "DescriçãoDescriçãoDescriçãoDescriçãoDescriçãoDescrição", isAnnoncement: true,),
      //_containerProfile(context)
    );
  }
}
