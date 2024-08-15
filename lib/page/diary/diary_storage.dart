import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'diary_model.dart';

class DiaryStorage {
  static const String _key = 'diaries';

  Future<List<Diary>> loadDiaries() async {
    final prefs = await SharedPreferences.getInstance();
    final String? diariesString = prefs.getString(_key);
    if (diariesString != null) {
      final List<dynamic> decodedList = jsonDecode(diariesString);
      return decodedList.map((item) => Diary.fromJson(item)).toList();
    }
    return [];
  }

  Future<void> saveDiaries(List<Diary> diaries) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedList = jsonEncode(diaries.map((diary) => diary.toJson()).toList());
    await prefs.setString(_key, encodedList);
  }
}