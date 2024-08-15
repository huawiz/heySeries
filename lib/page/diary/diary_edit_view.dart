import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'diary_model.dart';

class DiaryEditView extends StatefulWidget {
  final Diary? diary;
  final Function(Diary) onSave;
  final VoidCallback onCancel;

  DiaryEditView({this.diary, required this.onSave, required this.onCancel});

  @override
  _DiaryEditViewState createState() => _DiaryEditViewState();
}

class _DiaryEditViewState extends State<DiaryEditView> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.diary != null) {
      _titleController.text = widget.diary!.title;
      _contentController.text = widget.diary!.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.diary == null ? '撰寫日記' : '編輯日記'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: widget.onCancel,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: '今天的標題是...',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '請輸入標題';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _contentController,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: '今天發生了什麼...',
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.newline,
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '請輸入內容';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final diary = Diary(
                        title: _titleController.text,
                        content: _contentController.text,
                        date: DateTime.now(),
                      );
                      widget.onSave(diary);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      '儲存日記',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}