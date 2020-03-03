import 'dart:async';

import 'package:extra/entity/extra_job.dart';
import 'package:extra/entity/profile.dart';
import 'package:extra/pages/about.dart';
import 'package:extra/pages/profile_crud.dart';
import 'package:extra/pages/terms.dart';
import 'package:extra/pages/welcome/welcome.dart';
import 'package:extra/service/firebase_service.dart';
import 'package:extra/service/service.dart';
import 'package:extra/utils/consts.dart';
import 'package:extra/utils/event_bus.dart';
import 'package:extra/utils/prefs.dart';
import 'package:extra/utils/utils.dart';
import 'package:extra/utils/custom_search_delegate.dart';
import 'package:extra/pages/tab_extra.dart';
import 'package:extra/pages/tab_rede.dart';
import 'package:extra/pages/tab_conversation.dart';
import 'package:extra/utils/strings.dart';
import 'package:extra/widgets/loading.dart';
import 'package:extra/widgets/no_has_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class Home extends StatefulWidget {
  String nameFromLoginWithGoogle;

  Home({this.nameFromLoginWithGoogle});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;
  Profile p;
  bool isLoading = true;
  bool isUpdateProfile = false;
  List<Profile> pList;
  StreamSubscription<Event> subscription;

  final List<Text> myTabs = <Text>[
    Text(
      "${Strings.REDE}",
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
    Text(
      "${Strings.ANNOUNCEMENT}",
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
    Text(
      "${Strings.CONVERSATION}",
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    _checkUser();
    _updateProfile();
    final bus = EventBus.get(context);
    subscription = bus.stream.listen((Event e) {
      ExtraJob extraEvent = e;
      if (extraEvent.actionEvent == Consts.EVENT_PROFILE) _updateProfile();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _home(context);
  }

  _simplePopup() => PopupMenuButton<int>(
        onSelected: (i) {
          switch (i) {
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CrudProfile()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => About()),
              );
              break;
            case 3:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Terms()),
              );
              break;
            case 0:
              FirebaseService firebaseService = FirebaseService();
              firebaseService.logout();
              Utils().push(context, Welcome());
              break;
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text(Strings.MYACCOUNT),
          ),
          PopupMenuItem(
            value: 2,
            child: Text(Strings.ABOUT),
          ),
          PopupMenuItem(
            value: 3,
            child: Text(Strings.TERMS),
          ),
          PopupMenuItem(
            value: 0,
            child: Text(Strings.LOGOUT),
          ),
        ],
      );

  _home(context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                  }),
              _simplePopup(),
            ],
            title: Text(Strings.EXTRA),
            bottom: TabBar(
              labelPadding: EdgeInsets.all(10),
              indicatorColor: Colors.white,
              controller: _tabController,
              tabs: myTabs,
              onTap: null,
            ),
            elevation: 6,
          ),
          body: isLoading
              ? Loading()
              : TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    isUpdateProfile
                        ? _containerProfile()
                        : NoHasData(Strings.TEXT_FIRST_TIME),
                    _containerAnuncio(),
                    _containerChat()
                  ],
                ),
        ),
      ),
    );
  }

  _updateProfile() async {
    pList = await Service().getProfiles();
    setState(() {
      isUpdateProfile = true;
    });
  }

  _checkEmail() => (Prefs.getString(Consts.EMAIL));


  _containerProfile() {
    return ListView.builder(
        itemCount: pList != null && pList.isNotEmpty ? pList.length : 0,
        itemBuilder: (ctx, idx) {
          return TabRede(pList[idx] );
        });
  }

  _containerAnuncio() {
    return (p != null && p.extras != null && p.extras.isEmpty)
        ? Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 0, left: 5, right: 5, top: 5),
            child: Container(height: 200, child: NoHasData(Strings.NOTHING)),
          )
        : Container(
            child: ListView.builder(
                itemCount: p != null && p.extras != null && p.extras.isNotEmpty
                    ? p.extras.length
                    : 0,
                itemBuilder: (ctx, idx) {
                  return TabExtra(p.extras[idx], p);
                }),
          );
  }

  _containerChat() {
    return p == null || p.talks == null
        ? NoHasData(Strings.NO_HAS_DATA_CONVERSATION)
        : ListView(
            children: <Widget>[TabConversation(null)],
          );
  }

  void _checkUser() async {
    p = await Profile.get();
    if (p != null) {
      if (p.description != null &&
          p.pathPhoto != null &&
          p.name != null &&
          p.email != null &&
          p.phone != null &&
          p.mainFunction != null &&
          p.city != null &&
          p.state != null) {
        Prefs.setInt(Consts.ALL_DATA_PROFILE_OK, 2);
        Prefs.setString(Consts.EMAIL, p.email);
        p.isDataOk = true;
        p.isMe = true;
        p.save();
      }
    }

    if (await Prefs.getInt(Consts.ALL_DATA_PROFILE_OK) == 1) {
      _alertFirstTime(name: widget.nameFromLoginWithGoogle);
    }
    setState(() {
      isLoading = false;
    });
  }

  _alertFirstTime({String name}) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ClassicGeneralDialogWidget(
          positiveText: Strings.TTITLE_FIRST_TIME,
          titleText: " ${name ?? Strings.WELCOME}",
          contentText: Strings.TEXT_FIRST_TIME,
          onPositiveClick: () {
            Utils().pushNoReplacement(context, CrudProfile());
          },
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.easeInCirc,
      duration: Duration(seconds: 1),
    );
  }
}
