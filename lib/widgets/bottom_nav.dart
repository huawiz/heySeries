import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        // 設置 BottomNavigationBar 的主題
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Colors.blue, // 選中項目的顏色
          unselectedItemColor: Colors.grey, // 未選中項目的顏色
          backgroundColor: Colors.white, // 底部導航欄的背景顏色
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: onTap,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.psychology),
            label: 'Mind',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Compass',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.auto_stories),
            label: 'Diary',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.manage_accounts),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}