import 'package:flutter/material.dart';

import 'fate_chart.dart';
import 'random_event.dart';

class OraclePage extends StatelessWidget {
  const OraclePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: TabBar(tabs: [Tab(text: '是/否问题'), Tab(text: '随机事件')]),
            ),
            body: TabBarView(
              children: [FateChart(), RandomEvent()],
            )));
  }
}
