import 'dart:developer';

import 'package:extra/entity/profile.dart';
import 'package:extra/pages/tab_rede.dart';
import 'package:extra/service/service.dart';
import 'package:extra/utils/utils.dart';
import 'package:extra/widgets/card_item.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _content(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _content(context);
  }

  _content(context) {
    return FutureBuilder<List<Profile>>(
      future: _search(query),
      builder: (ctx, snap) {
        if (snap.data!= null && snap.data.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Utils().title(context, "Não achei nada")
            ],
          );
        } else {
          return ListView.builder(
            itemCount: snap.data == null ? 0 : snap.data.length,
            itemBuilder: (ctx, idx) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: CardItem(
                    snap.data[idx],
                    type: true,
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Future<List<Profile>> _search(String query) async {
    List<Profile> list = await Service().getProfiles();
    List<Profile> result = [];
    print(query);
    for (Profile pr in list) {
      if (pr.name.toLowerCase().contains(query.toLowerCase())) {
        result.add(pr);
      }
    }
    return result;
  }
}
