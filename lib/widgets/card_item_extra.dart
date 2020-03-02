import 'package:extra/entity/extra_job.dart';
import 'package:extra/entity/profile.dart';
import 'package:extra/pages/chat.dart';
import 'package:extra/pages/extra.dart';
import 'package:extra/pages/list_extra.dart';
import 'package:extra/pages/public_profile.dart';
import 'package:extra/utils/consts.dart';
import 'package:extra/utils/event_bus.dart';
import 'package:extra/utils/strings.dart';
import 'package:extra/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class CardItemExtra extends StatefulWidget {
  ExtraJob job;
  bool isShow;
  int indexToEdit;

  CardItemExtra(this.job,{ this.isShow = false, this.indexToEdit});

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
              widget.job.where,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.job.description,
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 18),
            ),
            Divider(color: Colors.black),
            widget.isShow
                ? _buttons(Strings.PROFILE, Strings.CONVERSATION)
                : _buttons(Strings.DELETE, Strings.EDIT)
          ],
        ),
      ),
    );
  }

  _buttons(String btn1, String btn2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton.icon(
            onPressed: () {
              if( !widget.isShow)
                  delete(context, widget.indexToEdit,);
              else
                Utils().pushNoReplacement(context, PublicProfile());
              

            },
            icon: Icon(widget.isShow ? Icons.visibility : Icons.delete),
            label: Text(btn1)),
        FlatButton.icon(
            onPressed: () {
              if( !widget.isShow )
                Utils().pushNoReplacement(context, Extra( editJob: widget.job, indice: widget.indexToEdit,));
              else
                Utils().pushNoReplacement(context, Chat(null));

            },
            icon: Icon(widget.isShow ? Icons.chat : Icons.edit),
            label: Text(btn2)),
      ],
    );
  }



  delete(context, int index, ) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          positiveText: Strings.YES,
          negativeText: Strings.NO,
          titleText: Strings.CONFIRM,
          contentText: Strings.DELETED,
          onPositiveClick: () async{
            Profile p = await Profile.get();
            List<ExtraJob> list = p.extras;
            list.removeAt(index);
            p.extras = list;
            p.save();
            Navigator.of(context).pop();
            EventBus.get(context)
                .sendEvent(ExtraJob(actionEvent: Consts.EVENT_JOB));
            //Utils().push(context, ListExtras());
          },
          onNegativeClick: (){
            Navigator.of(context).pop();
          },
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.easeInCirc,
      duration: Duration(seconds: 1),
    );
  }
}
