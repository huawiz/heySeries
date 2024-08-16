import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'journal_model.dart';

class JournalService {
  late Isar isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [JournalSchema],
      directory: dir.path,
    );
  }

  Future<List<Journal>> getAllDiaries() async {
    return await isar.journals.where().sortByDateDesc().findAll();
  }

  Future<void> addjournal(String title, String content, int engagementLevel, int energyLevel) async {
    final journal = Journal()
      ..title = title
      ..content = content
      ..date = DateTime.now()
      ..engagementLevel = engagementLevel
      ..energyLevel = energyLevel;

    await isar.writeTxn(() async {
      await isar.journals.put(journal);
    });
  }

  Future<void> updatejournal(Id id, String title, String content, int engagementLevel, int energyLevel) async {
    await isar.writeTxn(() async {
      final journal = await isar.journals.get(id);
      if (journal != null) {
        journal.title = title;
        journal.content = content;
        journal.engagementLevel = engagementLevel;
        journal.energyLevel = energyLevel;
        await isar.journals.put(journal);
      }
    });
  }

  Future<void> deletejournal(Id id) async {
    await isar.writeTxn(() async {
      await isar.journals.delete(id);
    });
  }

  Future<Journal?> getjournal(Id id) async {
    return await isar.journals.get(id);
  }

  void dispose() {
    isar.close();
  }
}