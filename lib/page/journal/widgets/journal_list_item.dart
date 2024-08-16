import 'package:flutter/material.dart';
import 'package:heyseries_dev/page/journal/model/journal_model.dart';
import 'package:intl/intl.dart';

class JournalListItem extends StatelessWidget {
  final Journal journal;
  final VoidCallback onView;
  final VoidCallback onDelete;

  const JournalListItem({
    super.key,
    required this.journal,
    required this.onView,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(journal.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(DateFormat('yyyy年MM月dd日 HH:mm').format(journal.date)),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.psychology, size: 16),
                SizedBox(width: 4),
                Text('投入程度: ${journal.engagementLevel}'),
                SizedBox(width: 16),
                Icon(Icons.battery_charging_full, size: 16),
                SizedBox(width: 4),
                Text('精力使用: ${journal.energyLevel}'),
              ],
            ),
          ],
        ),
        onTap: onView,
        trailing: IconButton(
          icon: Icon(Icons.delete, color: theme.primaryColor),
          onPressed: onDelete,
        ),
      ),
    );
  }
}