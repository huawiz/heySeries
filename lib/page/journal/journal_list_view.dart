import 'package:flutter/material.dart';
import '../journal/journal_model.dart';
import 'package:intl/intl.dart';

class JournalListView extends StatelessWidget {
  final List<Journal> diaries;
  final VoidCallback onAddNew;
  final Function(Journal) onViewjournal;
  final Function(Journal) onDeletejournal;

  JournalListView({
    required this.diaries,
    required this.onAddNew,
    required this.onViewjournal,
    required this.onDeletejournal,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Journal'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onAddNew,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add),
                          SizedBox(height: 4),
                          Text('新增日誌', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('每週摘要功能即將推出，敬請期待！')),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.summarize),
                          SizedBox(height: 4),
                          Text('每週摘要', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: diaries.isEmpty
                ? Center(child: Text('沒有日誌。點擊上方按鈕來新增日誌。'))
                : ListView.builder(
                    itemCount: diaries.length,
                    itemBuilder: (context, index) {
                      final journal = diaries[index];
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
                          onTap: () => onViewjournal(journal),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: theme.primaryColor),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('確認刪除'),
                                    content: Text('你確定要刪除這篇日誌嗎？'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('取消'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: Text('確定'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          onDeletejournal(journal);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('日誌已刪除')),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}