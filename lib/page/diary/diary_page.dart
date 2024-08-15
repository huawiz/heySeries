import 'package:flutter/material.dart';
import 'diary_list_view.dart';
import 'diary_edit_view.dart';
import 'diary_detail_view.dart';
import 'diary_model.dart';
import 'diary_storage.dart';

class DiaryPage extends StatefulWidget {
  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  bool _isWriting = false;
  bool _isViewing = false;
  bool _isEditing = false;
  List<Diary> _diaries = [];
  Diary? _currentDiary;
  int _currentDiaryIndex = -1;
  final DiaryStorage _storage = DiaryStorage();

  @override
  void initState() {
    super.initState();
    _loadDiaries();
  }

  void _loadDiaries() async {
    final diaries = await _storage.loadDiaries();
    setState(() {
      _diaries = diaries;
    });
  }

  void _saveDiary(Diary diary) {
    setState(() {
      if (_isEditing) {
        _diaries[_currentDiaryIndex] = diary;
      } else {
        _diaries.add(diary);
      }
      _isWriting = false;
      _isEditing = false;
      _isViewing = false;
    });
    _storage.saveDiaries(_diaries);
  }

  void _deleteDiary(int index) {
    setState(() {
      _diaries.removeAt(index);
    });
    _storage.saveDiaries(_diaries);
  }

  @override
  Widget build(BuildContext context) {
    if (_isWriting || _isEditing) {
      return DiaryEditView(
        diary: _isEditing ? _currentDiary : null,
        onSave: _saveDiary,
        onCancel: () => setState(() {
          _isWriting = false;
          _isEditing = false;
        }),
      );
    } else if (_isViewing) {
      return DiaryDetailView(
        diary: _currentDiary!,
        onEdit: () => setState(() {
          _isEditing = true;
        }),
        onBack: () => setState(() {
          _isViewing = false;
        }),
      );
    } else {
      return DiaryListView(
        diaries: _diaries,
        onAddNew: () => setState(() {
          _isWriting = true;
        }),
        onViewDiary: (diary, index) => setState(() {
          _currentDiary = diary;
          _currentDiaryIndex = index;
          _isViewing = true;
        }),
        onDeleteDiary: _deleteDiary,
      );
    }
  }
}