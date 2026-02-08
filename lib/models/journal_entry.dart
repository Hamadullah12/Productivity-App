class JournalEntry {
  String id;
  String title;
  String content;
  DateTime createdAt;
  String mood; // 'happy', 'neutral', 'stressed', 'motivated'

  JournalEntry({
    required this.id,
    this.title = '',
    required this.content,
    DateTime? createdAt,
    this.mood = 'neutral',
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'createdAt': createdAt.toIso8601String(),
        'mood': mood,
      };

  factory JournalEntry.fromJson(Map<String, dynamic> json) => JournalEntry(
        id: json['id'],
        title: json['title'] ?? '',
        content: json['content'],
        createdAt: DateTime.parse(json['createdAt']),
        mood: json['mood'] ?? 'neutral',
      );
}
