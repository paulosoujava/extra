import 'package:extra/entity/profile.dart';
import 'package:extra/pages/edit_profile.dart';
import 'package:extra/pages/welcome/welcome.dart';
import 'package:extra/service/service.dart';
import 'package:extra/utils/consts.dart';
import 'package:extra/utils/custom_search_delegate.dart';
import 'package:extra/pages/tab_extra.dart';
import 'package:extra/pages/tab_rede.dart';
import 'package:extra/pages/tab_conversation.dart';
import 'package:flutter/material.dart';

enum SingingCharacter { lafayette, jefferson }

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

  final List<Text> myTabs = <Text>[
    Text(
      "${Consts.REDE}",
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
    Text(
      "${Consts.ANNONCEMENT}",
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
    Text(
      "${Consts.CONVERSATION}",
      style: TextStyle(color: Colors.white, fontSize: 18),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
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
                MaterialPageRoute(builder: (context) => ProfileEdit()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Welcome()),
              );
              break;
          }
        },
        itemBuilder: (context) => [
          PopupMenuItem(
            value: 1,
            child: Text("Minha Conta"),
          ),
          PopupMenuItem(
            value: 2,
            child: Text("Sobre"),
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
            title: Text("Extra"),
            bottom: TabBar(
              labelPadding: EdgeInsets.all(10),
              indicatorColor: Colors.white,
              controller: _tabController,
              tabs: myTabs,
              onTap: null,
            ),
            elevation: 6,
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              _containerProfile(),
              _containerAnuncio(),
              _containerChat()
            ],
          ),
        ),
      ),
    );
  }

  _containerProfile() {
    return ListView(
      children: <Widget>[
        TabRede(Service().getProfile())
        //Service().getProfiles(),
      ],
    );
  }

  _containerAnuncio() {
    return Container(
      child: ListView(
        children: <Widget>[
          tab_extra(),
        ],
      ),
    );
  }

  _containerChat() {
    return ListView(
      children: <Widget>[
        TabConversation(Service().getProfile(),)
      ],
    );
  }
}
