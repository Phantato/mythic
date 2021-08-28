import 'package:flutter/material.dart';
import 'package:mythic/pages/threads.dart';

import 'scenes.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: TabBar(tabs: [Tab(text: '场景'), Tab(text: '线索')]),
            ),
            body: TabBarView(
              children: [SceneListView(), ThreadListView()],
            )));
  }
}
