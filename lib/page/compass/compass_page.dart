import 'package:flutter/material.dart';

class CompassPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: _buildButton(context, '建立人生觀', Colors.red),
            ),
            SizedBox(height: 16),  // 按鈕之間的間隔
            Flexible(
              flex: 3,
              child: _buildButton(context, '建立工作觀', Colors.green),
            ),
            SizedBox(height: 16),  // 按鈕之間的間隔
            Flexible(
              flex: 4,
              child: _buildButton(context, '建立奧德賽計畫', Colors.blue),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, Color color) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: ElevatedButton(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        onPressed: () {
          // 暫時不添加任何功能
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),  // 添加圓角
          ),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}