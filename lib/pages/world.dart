import 'package:flutter/material.dart';

import 'character.dart';
import 'location.dart';

class WorldPage extends StatelessWidget {
  const WorldPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: TabBar(tabs: [Tab(text: '角色'), Tab(text: '地点')]),
            ),
            body: TabBarView(
              children: [CharacterListView(), LocationListView()],
            )));
  }
}
