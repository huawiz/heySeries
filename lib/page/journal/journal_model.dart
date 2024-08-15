import 'package:isar/isar.dart';

part 'journal_model.g.dart';

@collection
class Journal {
  Id id = Isar.autoIncrement;
  late String title;
  late String content;
  late DateTime date;
  
  @Index()
  late int engagementLevel; 
  @Index()
  late int energyLevel;
}
