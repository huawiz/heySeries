import 'package:flutter/material.dart';
import 'journal_model.dart';
import 'journal_service.dart';
import 'journal_list_view.dart';
import 'journal_edit_view.dart';
import 'journal_detail_view.dart';

class JournalPage extends StatefulWidget {
  @override
  _journalPageState createState() => _journalPageState();
}

class _journalPageState extends State<JournalPage> {
  final journalService _journalService = journalService();
  List<Journal> _diaries = [];
  bool _isWriting = false;
  bool _isViewing = false;
  bool _isEditing = false;
  Journal? _currentjournal;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializejournalService();
  }

  Future<void> _initializejournalService() async {
    await _journalService.init();
    await _loadDiaries();
  }

  Future<void> _loadDiaries() async {
    setState(() => _isLoading = true);
    try {
      final diaries = await _journalService.getAllDiaries();
      setState(() {
        _diaries = diaries;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading diaries: $e');
      setState(() => _isLoading = false);
    }
  }

  void _startWriting() {
    setState(() {
      _isWriting = true;
      _isViewing = false;
      _isEditing = false;
      _currentjournal = null;
    });
  }

  void _startEditing(Journal journal) {
    setState(() {
      _isWriting = false;
      _isViewing = false;
      _isEditing = true;
      _currentjournal = journal;
    });
  }

  void _viewjournal(Journal journal) {
    setState(() {
      _isWriting = false;
      _isViewing = true;
      _isEditing = false;
      _currentjournal = journal;
    });
  }

  Future<void> _savejournal(String title, String content, int engagementLevel, int energyLevel) async {
    if (_isEditing && _currentjournal != null) {
      await _journalService.updatejournal(_currentjournal!.id, title, content, engagementLevel, energyLevel);
    } else {
      await _journalService.addjournal(title, content, engagementLevel, energyLevel);
    }
    await _loadDiaries();
    setState(() {
      _isWriting = false;
      _isEditing = false;
      _isViewing = false;
    });
  }

  Future<void> _deletejournal(Journal journal) async {
    await _journalService.deletejournal(journal.id);
    await _loadDiaries();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_isWriting || _isEditing) {
      return journalEditView(
        journal: _currentjournal,
        onSave: _savejournal,
        onCancel: () => setState(() {
          _isWriting = false;
          _isEditing = false;
        }),
      );
    } else if (_isViewing) {
      return journalDetailView(
        journal: _currentjournal!,
        onEdit: () => _startEditing(_currentjournal!),
        onBack: () => setState(() => _isViewing = false),
      );
    } else {
      return journalListView(
        diaries: _diaries,
        onAddNew: _startWriting,
        onViewjournal: _viewjournal,
        onDeletejournal: _deletejournal,
      );
    }
  }

  @override
  void dispose() {
    _journalService.dispose();
    super.dispose();
  }
}