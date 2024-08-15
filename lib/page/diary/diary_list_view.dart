import 'package:flutter/material.dart';
import 'diary_model.dart';

class DiaryListView extends StatelessWidget {
  final List<Diary> diaries;
  final VoidCallback onAddNew;
  final Function(Diary, int) onViewDiary;
  final Function(int) onDeleteDiary;

  DiaryListView({
    required this.diaries,
    required this.onAddNew,
    required this.onViewDiary,
    required this.onDeleteDiary,
  });

  String formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')} '
           '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: 8),
                          Text('新增日記', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: Size(0, 50),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('每週摘要功能即將推出！')),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.summarize),
                          SizedBox(width: 8),
                          Text('每週摘要', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: Size(0, 50),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: diaries.isEmpty
                ? Center(child: Text('沒有日記。點擊上方按鈕來新增日記。'))
                : ListView.builder(
                    itemCount: diaries.length,
                    itemBuilder: (context, index) {
                      final diary = diaries[diaries.length - 1 - index];
                      return Dismissible(
                        key: Key(diary.date.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20.0),
                          color: Colors.red,
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          onDeleteDiary(diaries.length - 1 - index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('日記已刪除')),
                          );
                        },
                        child: ListTile(
                          title: Text(diary.title),
                          subtitle: Text(formatDate(diary.date)),
                          onTap: () => onViewDiary(diary, diaries.length - 1 - index),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('確認刪除'),
                                    content: Text('你確定要刪除這篇日記嗎？'),
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
                                          onDeleteDiary(diaries.length - 1 - index);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('日記已刪除')),
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