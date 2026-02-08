class UserProfile {
  String name;
  String university;
  String year;
  String location;
  bool isDarkMode;
  int dailyGoal; // Number of tasks to complete daily
  bool notificationsEnabled;
  int streakCount;
  DateTime? lastActiveDate;
  List<String> motivationalQuotes;

  UserProfile({
    this.name = 'User',
    this.university = 'University',
    this.year = 'Second Year',
    this.location = 'Peshawar, Pakistan',
    this.isDarkMode = false,
    this.dailyGoal = 10,
    this.notificationsEnabled = true,
    this.streakCount = 0,
    this.lastActiveDate,
    List<String>? motivationalQuotes,
  }) : motivationalQuotes = motivationalQuotes ??
            [
              'Stay focused, stay strong! 💪',
              'Every task completed is progress! 🚀',
              'You\'re doing amazing, keep going! ⭐',
              'Consistency is the key to success! 🔑',
              'Today\'s effort is tomorrow\'s achievement! 🎯',
            ];

  Map<String, dynamic> toJson() => {
        'name': name,
        'university': university,
        'year': year,
        'location': location,
        'isDarkMode': isDarkMode,
        'dailyGoal': dailyGoal,
        'notificationsEnabled': notificationsEnabled,
        'streakCount': streakCount,
        'lastActiveDate': lastActiveDate?.toIso8601String(),
        'motivationalQuotes': motivationalQuotes,
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        name: json['name'] ?? 'User',
        university: json['university'] ?? 'University',
        year: json['year'] ?? 'Second Year',
        location: json['location'] ?? 'Peshawar, Pakistan',
        isDarkMode: json['isDarkMode'] ?? false,
        dailyGoal: json['dailyGoal'] ?? 10,
        notificationsEnabled: json['notificationsEnabled'] ?? true,
        streakCount: json['streakCount'] ?? 0,
        lastActiveDate: json['lastActiveDate'] != null
            ? DateTime.parse(json['lastActiveDate'])
            : null,
        motivationalQuotes: json['motivationalQuotes'] != null
            ? List<String>.from(json['motivationalQuotes'])
            : null,
      );
}
