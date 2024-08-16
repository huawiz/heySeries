import 'package:flutter/material.dart';
import '../journal/journal_model.dart';

class JournalEditView extends StatefulWidget {
  final Journal? journal;
  final Function(String, String, int, int) onSave;
  final VoidCallback onCancel;

  JournalEditView({this.journal, required this.onSave, required this.onCancel});

  @override
  State<JournalEditView> createState() {
    return _JournalEditViewState();
  }
}

class _JournalEditViewState extends State<JournalEditView> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  int _engagementLevel = 5;
  int _energyLevel = 5;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.journal?.title ?? '');
    _contentController =
        TextEditingController(text: widget.journal?.content ?? '');
    if (widget.journal != null) {
      _engagementLevel = widget.journal!.engagementLevel;
      _energyLevel = widget.journal!.energyLevel;
    }
  }

  bool _validateInputs() {
    if (_titleController.text.trim().isEmpty ||
        _contentController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('標題和內容不能為空')),
      );
      return false;
    }
    return true;
  }

  void _handleSave() {
    if (_validateInputs()) {
      widget.onSave(_titleController.text.trim(),
          _contentController.text.trim(), _engagementLevel, _energyLevel);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.journal == null ? '新增日誌' : '編輯日誌'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: '標題',
                      hintText: '請輸入日誌標題',
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      labelText: '內容',
                      hintText: '請輸入日誌內容',
                    ),
                    maxLines: null,
                  ),
                  SizedBox(height: 16),
                  Text('投入程度 (1-10)', style: theme.textTheme.titleLarge),
                  Slider(
                    value: _engagementLevel.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: _engagementLevel.toString(),
                    onChanged: (value) {
                      setState(() {
                        _engagementLevel = value.round();
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  Text('精力使用 (1-10)', style: theme.textTheme.titleLarge),
                  Slider(
                    value: _energyLevel.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: _energyLevel.toString(),
                    onChanged: (value) {
                      setState(() {
                        _energyLevel = value.round();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            color: theme.primaryColorLight,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.onCancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.secondaryHeaderColor,
                      foregroundColor: theme.primaryColorDark,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text('放棄', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _handleSave,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text('儲存', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }
}
