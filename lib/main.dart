import 'package:flutter/material.dart';

import 'icons/icons.dart';
import 'pages/pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final pagesList = [
    OraclePage(),
    StoryPage(),
    WorldPage(),
  ];
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);

  final _titles = [
    Text('神谕'),
    Text('故事'),
    Text('世界'),
  ];

  @override
  void initState() {
    super.initState();
  }

  void changePage(value) => setState(() {
        _currentIndex = value;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _titles[_currentIndex],
      ),
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: changePage,
        itemCount: widget.pagesList.length,
        itemBuilder: (_, index) => Center(child: widget.pagesList[index]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (value) => _pageController.animateToPage(value,
            duration: Duration(milliseconds: 300), curve: Curves.ease),
        items: [
          BottomNavigationBarItem(
            label: '神谕',
            icon: Icon(RpgIcons.perspective_dice_random),
          ),
          BottomNavigationBarItem(
            label: '故事',
            icon: Icon(RpgIcons.book),
          ),
          BottomNavigationBarItem(
            label: '世界',
            icon: Icon(RpgIcons.player),
          ),
        ],
      ),
    );
  }
}
