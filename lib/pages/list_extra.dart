import 'dart:async';

import 'package:extra/entity/extra_job.dart';
import 'package:extra/entity/profile.dart';
import 'package:extra/pages/extra.dart';
import 'package:extra/utils/consts.dart';
import 'package:extra/utils/event_bus.dart';
import 'package:extra/utils/strings.dart';
import 'package:extra/utils/utils.dart';
import 'package:extra/widgets/loading.dart';
import 'package:extra/widgets/no_has_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:extra/widgets/card_item_extra.dart';

class ListExtras extends StatefulWidget {
  @override
  _ListExtrasState createState() => _ListExtrasState();
}

class _ListExtrasState extends State<ListExtras> {
  Profile p;
  bool isLoading = true;
  StreamSubscription<Event> subscription;

  @override
  void initState() {
    _load();
    super.initState();
    final bus = EventBus.get(context);
    subscription = bus.stream.listen((Event e) {
      ExtraJob extraEvent = e;
      if (extraEvent.actionEvent == Consts.EVENT_JOB) _load();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.EXTRA),
        actions: <Widget>[
          (p != null && p.extras != null && p.extras.length > 0)
              ? Container()
              : IconButton(
                  icon: Icon(Icons.add_circle),
                  onPressed: () {
                    Utils().pushNoReplacement(context, Extra());
                  },
                ),
        ],
      ),
      body: isLoading
          ? Loading()
          : (p != null && p.extras != null && p.extras.isEmpty)
              ? Container(
                  height: 150,
                  child: Card(
                    elevation: 8,
                    child: NoHasData(Strings.NOTHING_CREATE),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: p.extras == null ? 0 : p.extras.length,
                    itemBuilder: (context, index) {
                      return CardItemExtra(
                        p.extras[index],
                        p,
                        indexToEdit: index,
                      );
                    },
                  ),
                ),
    );
  }

  _load() async {
    p = await Profile.get();
    setState(() {
      isLoading = false;
    });
  }
}
