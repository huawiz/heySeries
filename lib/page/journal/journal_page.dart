import 'package:flutter/material.dart';
import 'package:heyseries_dev/page/journal/model/journal_model.dart';
import 'package:heyseries_dev/page/journal/journal_service.dart';
import 'package:heyseries_dev/page/journal/views/journal_list_view.dart';
import 'package:heyseries_dev/page/journal/views/journal_edit_view.dart';
import 'package:heyseries_dev/page/journal/views/journal_detail_view.dart';


class JournalPage extends StatefulWidget {
  @override
  State<JournalPage> createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final JournalService _journalService = JournalService();
  List<Journal> _diaries = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeJournalService();
  }

  Future<void> _initializeJournalService() async {
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

  Future<void> _navigateToEditPage([Journal? journal]) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JournalEditPage(journal: journal),
      ),
    );

    if (result == true) {
      await _loadDiaries();
    }
  }

  Future<void> _navigateToDetailView(Journal journal) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JournalDetailView(
          journal: journal,
          onEdit: () {
            Navigator.pop(context);
            _navigateToEditPage(journal);
          },
          onBack: () => Navigator.pop(context),
        ),
      ),
    );
    // 每次從詳情頁返回時都重新加載日誌列表，以確保顯示最新數據
    await _loadDiaries();
  }

  Future<void> _deleteJournal(Journal journal) async {
    await _journalService.deletejournal(journal.id);
    await _loadDiaries();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Journal')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return JournalListView(
      diaries: _diaries,
      onAddNew: () => _navigateToEditPage(),
      onViewJournal: _navigateToDetailView,
      onDeleteJournal: _deleteJournal,
    );
  }

  @override
  void dispose() {
    _journalService.dispose();
    super.dispose();
  }
}