import 'package:flutter/material.dart';
import 'journal_model.dart';

class journalDetailView extends StatelessWidget {
  final Journal journal;
  final VoidCallback onEdit;
  final VoidCallback onBack;

  journalDetailView(
      {required this.journal, required this.onEdit, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('日誌內容'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEdit,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              journal.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Text(
              '${journal.date.year}年${journal.date.month}月${journal.date.day}日 ${journal.date.hour}:${journal.date.minute}',
              style: TextStyle(fontSize: 14),
            ),
                Spacer(), // 左側留空，將內容推到右側
                Icon(Icons.psychology, size: 16),
                SizedBox(width: 4),
                Text('${journal.engagementLevel}'),
                SizedBox(width: 16),
                Icon(Icons.battery_charging_full, size: 16),
                SizedBox(width: 4),
                Text('${journal.energyLevel}'),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  journal.content,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
