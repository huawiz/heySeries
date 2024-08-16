import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'model/journal_model.dart';

class JournalService {
  static final JournalService _instance = JournalService._internal();
  Isar? _isar;

  factory JournalService() {
    return _instance;
  }

  JournalService._internal();

  Future<void> init() async {
    if (_isar != null) return;
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [JournalSchema],
      directory: dir.path,
    );
  }

  Future<void> dispose() async {
    await _isar?.close();
    _isar = null;
  }

  Future<List<Journal>> getAllDiaries() async {
    await init();
    return await _isar!.journals.where().sortByDateDesc().findAll();
  }

  Future<void> addjournal(String title, String content, int engagementLevel, int energyLevel) async {
    await init();
    final journal = Journal()
      ..title = title
      ..content = content
      ..date = DateTime.now()
      ..engagementLevel = engagementLevel
      ..energyLevel = energyLevel;

    await _isar!.writeTxn(() async {
      await _isar!.journals.put(journal);
    });
  }

  Future<void> updatejournal(Id id, String title, String content, int engagementLevel, int energyLevel) async {
    await init();
    await _isar!.writeTxn(() async {
      final journal = await _isar!.journals.get(id);
      if (journal != null) {
        journal.title = title;
        journal.content = content;
        journal.engagementLevel = engagementLevel;
        journal.energyLevel = energyLevel;
        await _isar!.journals.put(journal);
      }
    });
  }

  Future<void> deletejournal(Id id) async {
    await init();
    await _isar!.writeTxn(() async {
      await _isar!.journals.delete(id);
    });
  }

  Future<Journal?> getjournal(Id id) async {
    await init();
    return await _isar!.journals.get(id);
  }
}