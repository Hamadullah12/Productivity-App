class DailyRecord {
  String date; // Format: yyyy-MM-dd
  int completedTasks;
  int totalTasks;
  double efficiencyPercentage;
  int focusMinutes; // Total minutes in focus mode
  List<String> completedTaskIds;
  DateTime createdAt;

  DailyRecord({
    required this.date,
    this.completedTasks = 0,
    this.totalTasks = 0,
    this.efficiencyPercentage = 0.0,
    this.focusMinutes = 0,
    List<String>? completedTaskIds,
    DateTime? createdAt,
  })  : completedTaskIds = completedTaskIds ?? [],
        createdAt = createdAt ?? DateTime.now();

  double get scorePercentage =>
      totalTasks > 0 ? (completedTasks / totalTasks) * 100 : 0.0;

  Map<String, dynamic> toJson() => {
        'date': date,
        'completedTasks': completedTasks,
        'totalTasks': totalTasks,
        'efficiencyPercentage': efficiencyPercentage,
        'focusMinutes': focusMinutes,
        'completedTaskIds': completedTaskIds,
        'createdAt': createdAt.toIso8601String(),
      };

  factory DailyRecord.fromJson(Map<String, dynamic> json) => DailyRecord(
        date: json['date'],
        completedTasks: json['completedTasks'] ?? 0,
        totalTasks: json['totalTasks'] ?? 0,
        efficiencyPercentage: (json['efficiencyPercentage'] ?? 0.0).toDouble(),
        focusMinutes: json['focusMinutes'] ?? 0,
        completedTaskIds: List<String>.from(json['completedTaskIds'] ?? []),
        createdAt: DateTime.parse(json['createdAt']),
      );
}
