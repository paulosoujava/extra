import 'package:extra/entity/extra_job.dart';
import 'package:extra/utils/strings.dart';
import 'package:extra/utils/utils.dart';
import 'package:extra/widgets/card_item_extra.dart';
import 'package:extra/widgets/no_has_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabExtra extends StatelessWidget {
  ExtraJob job;

  TabExtra(this.job);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CardItemExtra(
          ExtraJob(description: job.description, where: job.where),
          isShow: true,
        ));
  }
}
