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
    Text('1'),
    Text('2'),
    Text('3'),
    Text('4'),
  ];
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final PageController _pageController =
      PageController(initialPage: 0, keepPage: true);

  final _titles = [
    Text('Oracle'),
    Text('Threads'),
    Text('NPCs'),
    Text('Locations'),
    Text('Screens'),
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
        // backgroundColor: Color.,
        // selectedItemColor: Colors.white,
        // unselectedItemColor: Colors.white.withOpacity(.6),
        // selectedFontSize: 14,
        // unselectedFontSize: 14,
        onTap: (value) => _pageController.animateToPage(value,
            duration: Duration(milliseconds: 300), curve: Curves.ease),
        items: [
          BottomNavigationBarItem(
            label: 'Oracle',
            icon: Icon(RpgIcons.perspective_dice_random),
          ),
          BottomNavigationBarItem(
            label: 'Threads',
            icon: Icon(RpgIcons.trophy),
          ),
          BottomNavigationBarItem(
            label: 'NPCs',
            icon: Icon(RpgIcons.player),
          ),
          BottomNavigationBarItem(
            label: 'Locations',
            icon: Icon(RpgIcons.wooden_sign),
          ),
          BottomNavigationBarItem(
            label: 'Screens',
            icon: Icon(RpgIcons.book),
          ),
        ],
      ),
    );
  }
}
