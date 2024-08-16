import 'package:flutter/material.dart';
import 'package:heyseries_dev/page/journal/model/journal_model.dart';
import 'journal_list_item.dart';

class JournalListContent extends StatelessWidget {
  final List<Journal> diaries;
  final Function(Journal) onViewJournal;
  final Function(Journal) onDeleteJournal;

  const JournalListContent({
    super.key,
    required this.diaries,
    required this.onViewJournal,
    required this.onDeleteJournal,
  });

  @override
  Widget build(BuildContext context) {
    return diaries.isEmpty
        ? Center(child: Text('沒有日誌。點擊上方按鈕來新增日誌。'))
        : ListView.builder(
            itemCount: diaries.length,
            itemBuilder: (context, index) {
              final journal = diaries[index];
              return JournalListItem(
                journal: journal,
                onView: () => onViewJournal(journal),
                onDelete: () => _showDeleteConfirmation(context, journal),
              );
            },
          );
  }

  void _showDeleteConfirmation(BuildContext context, Journal journal) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('確認刪除'),
          content: Text('你確定要刪除這篇日誌嗎？'),
          actions: <Widget>[
            TextButton(
              child: Text('取消'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('確定'),
              onPressed: () {
                Navigator.of(context).pop();
                onDeleteJournal(journal);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('日誌已刪除')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}