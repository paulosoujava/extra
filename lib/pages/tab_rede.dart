import 'package:extra/entity/profile.dart';
import 'package:extra/utils/strings.dart';
import 'package:extra/widgets/no_has_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:extra/widgets/card_item.dart';

class TabRede extends StatelessWidget {
  Profile profile;

  TabRede(this.profile);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 0, left: 5, right: 5, top: 5),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CardItem(
                  profile,
                  type: true,
                )

          ),
    );
  }

}
