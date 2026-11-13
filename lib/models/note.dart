/// Model untuk merepresentasikan catatan kuliah.
class Note {
  final String id;
  final String title;
  final String content;
  final DateTime date;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
  });

  /// Konversi metadata ke JSON untuk SharedPreferences
  Map<String, dynamic> toJsonMetadata() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
    };
  }
}