import 'package:flutter/material.dart';
import 'package:heyseries_dev/page/journal/journal_service.dart';
import 'package:heyseries_dev/page/journal/model/journal_model.dart';

class JournalEditPage extends StatefulWidget {
  final Journal? journal;

  const JournalEditPage({super.key, this.journal});

  @override
  State<JournalEditPage> createState() {
    return _JournalEditPageState();
  }
}

class _JournalEditPageState extends State<JournalEditPage> {
  final JournalService _journalService = JournalService();
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late int _engagementLevel;
  late int _energyLevel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.journal?.title ?? '');
    _contentController =
        TextEditingController(text: widget.journal?.content ?? '');
    _engagementLevel = widget.journal?.engagementLevel ?? 5;
    _energyLevel = widget.journal?.energyLevel ?? 5;
  }

  Future<void> _saveJournal() async {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('標題和內容不能為空')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (widget.journal != null) {
        await _journalService.updatejournal(
          widget.journal!.id,
          _titleController.text,
          _contentController.text,
          _engagementLevel,
          _energyLevel,
        );
      } else {
        await _journalService.addjournal(
          _titleController.text,
          _contentController.text,
          _engagementLevel,
          _energyLevel,
        );
      }
      Navigator.pop(context, true);
    } catch (e) {
      print('Error saving journal: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('保存失敗，請稍後再試')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.journal == null ? '新增日誌' : '編輯日誌'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(labelText: '標題'),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _contentController,
                    decoration: InputDecoration(labelText: '內容'),
                    maxLines: 10,
                  ),
                  SizedBox(height: 16),
                  Text('投入程度'),
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
                  Text('精力使用'),
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
                  SizedBox(height: 32),
                  ElevatedButton(
                    child: Text('儲存'),
                    onPressed: _saveJournal,
                  ),
                ],
              ),
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
