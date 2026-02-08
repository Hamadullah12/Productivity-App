class Task {
  String id;
  String title;
  String? description;
  bool isCompleted;
  DateTime? scheduledTime;
  int? duration; // in minutes
  int? targetValue; // e.g., 15 for push-ups
  String category; // 'exercise', 'study', 'health', 'spiritual', 'other'
  bool notificationEnabled;
  DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.isCompleted = false,
    this.scheduledTime,
    this.duration,
    this.targetValue,
    this.category = 'other',
    this.notificationEnabled = true,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();


  // Copy with method for easy updates
  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? scheduledTime,
    int? duration,
    int? targetValue,
    String? category,
    bool? notificationEnabled,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      duration: duration ?? this.duration,
      targetValue: targetValue ?? this.targetValue,
      category: category ?? this.category,
      notificationEnabled: notificationEnabled ?? this.notificationEnabled,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'isCompleted': isCompleted,
        'scheduledTime': scheduledTime?.toIso8601String(),
        'duration': duration,
        'targetValue': targetValue,
        'category': category,
        'notificationEnabled': notificationEnabled,
        'createdAt': createdAt.toIso8601String(),
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        isCompleted: json['isCompleted'] ?? false,
        scheduledTime: json['scheduledTime'] != null
            ? DateTime.parse(json['scheduledTime'])
            : null,
        duration: json['duration'],
        targetValue: json['targetValue'],
        category: json['category'] ?? 'other',
        notificationEnabled: json['notificationEnabled'] ?? true,
        createdAt: DateTime.parse(json['createdAt']),
      );
}
