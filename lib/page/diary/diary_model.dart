class Diary {
  final String title;
  final String content;
  final DateTime date;

  Diary({required this.title, required this.content, required this.date});

  Map<String, dynamic> toJson() => {
    'title': title,
    'content': content,
    'date': date.toIso8601String(),
  };

  factory Diary.fromJson(Map<String, dynamic> json) => Diary(
    title: json['title'],
    content: json['content'],
    date: DateTime.parse(json['date']),
  );
}