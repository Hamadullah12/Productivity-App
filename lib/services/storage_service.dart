import 'package:hive_flutter/hive_flutter.dart';
import '../models/task.dart';
import '../models/daily_record.dart';
import '../models/user_profile.dart';
import '../models/journal_entry.dart';

class StorageService {
  static const String tasksBox = 'tasks';
  static const String dailyRecordsBox = 'daily_records';
  static const String userProfileBox = 'user_profile';
  static const String journalBox = 'journal_entries';

  // Task operations
  static Box get tasksBoxInstance => Hive.box(tasksBox);

  static Future<void> addTask(Task task) async {
    await tasksBoxInstance.put(task.id, task.toJson());
  }

  static Future<void> updateTask(Task task) async {
    await tasksBoxInstance.put(task.id, task.toJson());
  }

  static Future<void> deleteTask(String taskId) async {
    await tasksBoxInstance.delete(taskId);
  }

  static List<Task> getAllTasks() {
    return tasksBoxInstance.values
        .map((json) => Task.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  static Task? getTask(String taskId) {
    final json = tasksBoxInstance.get(taskId);
    if (json == null) return null;
    return Task.fromJson(Map<String, dynamic>.from(json));
  }

  // Daily Record operations
  static Box get dailyRecordsBoxInstance => Hive.box(dailyRecordsBox);

  static Future<void> saveDailyRecord(DailyRecord record) async {
    await dailyRecordsBoxInstance.put(record.date, record.toJson());
  }

  static DailyRecord? getDailyRecord(String date) {
    final json = dailyRecordsBoxInstance.get(date);
    if (json == null) return null;
    return DailyRecord.fromJson(Map<String, dynamic>.from(json));
  }

  static List<DailyRecord> getAllDailyRecords() {
    return dailyRecordsBoxInstance.values
        .map((json) => DailyRecord.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  // User Profile operations
  static Box get userProfileBoxInstance => Hive.box(userProfileBox);

  static Future<void> saveUserProfile(UserProfile profile) async {
    await userProfileBoxInstance.put('profile', profile.toJson());
  }

  static UserProfile? getUserProfile() {
    final json = userProfileBoxInstance.get('profile');
    if (json == null) return null;
    return UserProfile.fromJson(Map<String, dynamic>.from(json));
  }

  // Journal operations
  static Box get journalBoxInstance => Hive.box(journalBox);

  static Future<void> addJournalEntry(JournalEntry entry) async {
    await journalBoxInstance.put(entry.id, entry.toJson());
  }

  static Future<void> deleteJournalEntry(String entryId) async {
    await journalBoxInstance.delete(entryId);
  }

  static List<JournalEntry> getAllJournalEntries() {
    final entries = journalBoxInstance.values
        .map((json) => JournalEntry.fromJson(Map<String, dynamic>.from(json)))
        .toList();
    entries.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return entries;
  }

  // Export data as JSON
  static Map<String, dynamic> exportAllData() {
    return {
      'tasks': getAllTasks().map((t) => t.toJson()).toList(),
      'dailyRecords': getAllDailyRecords().map((r) => r.toJson()).toList(),
      'userProfile': getUserProfile()?.toJson(),
      'journalEntries': getAllJournalEntries().map((e) => e.toJson()).toList(),
      'exportedAt': DateTime.now().toIso8601String(),
    };
  }

  // Clear all data (for testing/reset)
  static Future<void> clearAllData() async {
    await tasksBoxInstance.clear();
    await dailyRecordsBoxInstance.clear();
    await journalBoxInstance.clear();
  }
}
