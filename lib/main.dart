import 'package:flutter/material.dart';
import 'package:heyseries_dev/widgets/bottom_nav.dart';
import 'package:heyseries_dev/page/home/home_page.dart'; 
import 'package:heyseries_dev/page/compass/compass_page.dart'; 
import 'package:heyseries_dev/page/journal/journal_page.dart'; 
import 'package:heyseries_dev/page/mind/mind_page.dart'; 
import 'package:heyseries_dev/page/setting/setting_page.dart'; 
import 'package:heyseries_dev/theme.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
      theme: AppTheme.themeData,
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() {
    return _MainPageState();
  }
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    MindPage(),
    CompassPage(),
    JournalPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('heySeries_Dev'),
      ),*/
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

