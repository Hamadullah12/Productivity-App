import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import '../models/task.dart';
import '../models/daily_record.dart';
import '../models/user_profile.dart';
import '../models/journal_entry.dart';
import '../services/storage_service.dart';
import '../services/notification_service.dart';

class AppProvider extends ChangeNotifier {
  // User Profile
  UserProfile _userProfile = UserProfile();
  UserProfile get userProfile => _userProfile;

  // Tasks
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;
  List<Task> get todayTasks => _tasks;

  // Daily Records
  List<DailyRecord> _dailyRecords = [];
  List<DailyRecord> get dailyRecords => _dailyRecords;

  // Journal Entries
  List<JournalEntry> _journalEntries = [];
  List<JournalEntry> get journalEntries => _journalEntries;

  // Focus Timer
  bool _isFocusMode = false;
  int _focusSecondsRemaining = 0;
  int _totalFocusMinutesToday = 0;

  bool get isFocusMode => _isFocusMode;
  int get focusSecondsRemaining => _focusSecondsRemaining;
  int get totalFocusMinutesToday => _totalFocusMinutesToday;

  // Loading state
  bool _isLoading = true;
  bool get isLoading => _isLoading;

  // Initialize app
  Future<void> initialize() async {
    _isLoading = true;
    notifyListeners();

    // Load user profile
    _userProfile = StorageService.getUserProfile() ??
        UserProfile(
          name: 'Hamad',
          university: 'Software Engineering Student',
          year: 'Second Year',
          location: 'Peshawar, Pakistan',
        );

    // Load tasks
    _tasks = StorageService.getAllTasks();

    // Load daily records
    _dailyRecords = StorageService.getAllDailyRecords();

    // Load journal entries
    _journalEntries = StorageService.getAllJournalEntries();

    // Check and update streak
    _updateStreak();

    // Initialize default tasks if first time
    if (_tasks.isEmpty) {
      await _initializeDefaultTasks();
    }

    // Update today's record
    await _updateTodayRecord();

    _isLoading = false;
    notifyListeners();
  }

  // Initialize default tasks (inspired by the user's example)
  Future<void> _initializeDefaultTasks() async {
    final defaultTasks = [
      Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: '15 Push-ups',
        description: 'Complete 15 push-ups',
        category: 'exercise',
        targetValue: 15,
        scheduledTime:
            DateTime.now().copyWith(hour: 7, minute: 0, second: 0),
      ),
      Task(
        id: (DateTime.now().millisecondsSinceEpoch + 1).toString(),
        title: '6-min Meditation',
        description: 'Practice mindfulness meditation',
        category: 'health',
        duration: 6,
        scheduledTime:
            DateTime.now().copyWith(hour: 7, minute: 20, second: 0),
      ),
      Task(
        id: (DateTime.now().millisecondsSinceEpoch + 2).toString(),
        title: '1-min Plank',
        description: 'Hold plank position',
        category: 'exercise',
        duration: 1,
        scheduledTime:
            DateTime.now().copyWith(hour: 7, minute: 30, second: 0),
      ),
      Task(
        id: (DateTime.now().millisecondsSinceEpoch + 3).toString(),
        title: '6 Hours Study',
        description: 'Focused study sessions',
        category: 'study',
        duration: 360,
        scheduledTime:
            DateTime.now().copyWith(hour: 9, minute: 0, second: 0),
      ),
      Task(
        id: (DateTime.now().millisecondsSinceEpoch + 4).toString(),
        title: 'Watch Informative Video',
        description: 'Educational content',
        category: 'study',
        scheduledTime:
            DateTime.now().copyWith(hour: 19, minute: 0, second: 0),
      ),
      Task(
        id: (DateTime.now().millisecondsSinceEpoch + 5).toString(),
        title: 'No Junk Food',
        description: 'Maintain healthy eating',
        category: 'health',
      ),
      Task(
        id: (DateTime.now().millisecondsSinceEpoch + 6).toString(),
        title: 'Pray',
        description: 'Complete daily prayers',
        category: 'spiritual',
      ),
      Task(
        id: (DateTime.now().millisecondsSinceEpoch + 7).toString(),
        title: 'Attend Classes',
        description: 'Attend all scheduled classes',
        category: 'study',
        scheduledTime:
            DateTime.now().copyWith(hour: 8, minute: 30, second: 0),
      ),
      Task(
        id: (DateTime.now().millisecondsSinceEpoch + 8).toString(),
        title: '5 Pull-ups',
        description: 'Complete 5 pull-ups',
        category: 'exercise',
        targetValue: 5,
        scheduledTime:
            DateTime.now().copyWith(hour: 18, minute: 0, second: 0),
      ),
      Task(
        id: (DateTime.now().millisecondsSinceEpoch + 9).toString(),
        title: 'Plan Next Day',
        description: 'Review and plan tomorrow',
        category: 'other',
        scheduledTime:
            DateTime.now().copyWith(hour: 21, minute: 0, second: 0),
      ),
    ];

    for (var task in defaultTasks) {
      await StorageService.addTask(task);
      if (task.scheduledTime != null && _userProfile.notificationsEnabled) {
        await NotificationService.scheduleTaskReminder(task);
      }
    }

    _tasks = StorageService.getAllTasks();
    notifyListeners();
  }

  // Add task
  Future<void> addTask(Task task) async {
    await StorageService.addTask(task);
    if (task.scheduledTime != null && _userProfile.notificationsEnabled) {
      await NotificationService.scheduleTaskReminder(task);
    }
    _tasks = StorageService.getAllTasks();
    await _updateTodayRecord();
    notifyListeners();
  }

  // Update task
  Future<void> updateTask(Task task) async {
    await StorageService.updateTask(task);
    if (task.scheduledTime != null && _userProfile.notificationsEnabled) {
      await NotificationService.cancelNotification(task.id.hashCode);
      await NotificationService.scheduleTaskReminder(task);
    }
    _tasks = StorageService.getAllTasks();
    await _updateTodayRecord();
    notifyListeners();
  }

  // Toggle task completion
  Future<void> toggleTaskCompletion(String taskId) async {
    final task = StorageService.getTask(taskId);
    if (task != null) {
      task.isCompleted = !task.isCompleted;
      await StorageService.updateTask(task);
      _tasks = StorageService.getAllTasks();
      await _updateTodayRecord();

      // Send motivational notification if score is improving
      final todayRecord = _getTodayRecord();
      if (todayRecord != null &&
          task.isCompleted &&
          todayRecord.scorePercentage >= 70) {
        await NotificationService.sendMotivationalNotification(
          _userProfile.motivationalQuotes[
              DateTime.now().millisecond % _userProfile.motivationalQuotes.length],
        );
      }

      notifyListeners();
    }
  }

  // Delete task
  Future<void> deleteTask(String taskId) async {
    await StorageService.deleteTask(taskId);
    await NotificationService.cancelNotification(taskId.hashCode);
    _tasks = StorageService.getAllTasks();
    await _updateTodayRecord();
    notifyListeners();
  }

  // Update today's record
  Future<void> _updateTodayRecord() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final completedTasks = _tasks.where((t) => t.isCompleted).length;
    final totalTasks = _tasks.length;

    final record = DailyRecord(
      date: today,
      completedTasks: completedTasks,
      totalTasks: totalTasks,
      efficiencyPercentage: _calculateEfficiency(),
      focusMinutes: _totalFocusMinutesToday,
      completedTaskIds: _tasks.where((t) => t.isCompleted).map((t) => t.id).toList(),
    );

    await StorageService.saveDailyRecord(record);
    _dailyRecords = StorageService.getAllDailyRecords();
  }

  // Calculate efficiency (can be enhanced with more factors)
  double _calculateEfficiency() {
    final completedTasks = _tasks.where((t) => t.isCompleted).length;
    final totalTasks = _tasks.length;

    if (totalTasks == 0) return 0;

    // Basic efficiency: completion rate
    final completionRate = (completedTasks / totalTasks) * 100;

    // Bonus for focus time (up to 20% bonus)
    final focusBonus = (_totalFocusMinutesToday / 120).clamp(0, 1) * 20;

    return (completionRate * 0.8 + focusBonus).clamp(0, 100);
  }

  // Get today's record
  DailyRecord? _getTodayRecord() {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return StorageService.getDailyRecord(today);
  }

  // Update user profile
  Future<void> updateUserProfile(UserProfile profile) async {
    _userProfile = profile;
    await StorageService.saveUserProfile(profile);
    notifyListeners();
  }

  // Update streak
  void _updateStreak() {
    final today = DateTime.now();
    final lastActive = _userProfile.lastActiveDate;

    if (lastActive == null) {
      _userProfile.streakCount = 1;
    } else {
      final difference = today.difference(lastActive).inDays;

      if (difference == 0) {
        // Same day, no change
      } else if (difference == 1) {
        // Consecutive day
        _userProfile.streakCount++;
      } else {
        // Streak broken
        _userProfile.streakCount = 1;
      }
    }

    _userProfile.lastActiveDate = today;
    StorageService.saveUserProfile(_userProfile);
  }

  // Journal methods
  Future<void> addJournalEntry(JournalEntry entry) async {
    await StorageService.addJournalEntry(entry);
    _journalEntries = StorageService.getAllJournalEntries();
    notifyListeners();
  }

  Future<void> deleteJournalEntry(String entryId) async {
    await StorageService.deleteJournalEntry(entryId);
    _journalEntries = StorageService.getAllJournalEntries();
    notifyListeners();
  }

  // Focus mode methods
  void startFocusMode(int minutes) {
    _isFocusMode = true;
    _focusSecondsRemaining = minutes * 60;
    notifyListeners();
  }

  void tickFocusTimer() {
    if (_focusSecondsRemaining > 0) {
      _focusSecondsRemaining--;
      if (_focusSecondsRemaining % 60 == 0) {
        _totalFocusMinutesToday++;
        _updateTodayRecord();
      }
      notifyListeners();
    } else {
      stopFocusMode();
    }
  }

  void stopFocusMode() {
    _isFocusMode = false;
    _focusSecondsRemaining = 0;
    notifyListeners();
  }

  // Export data
  String exportDataAsJson() {
    final data = StorageService.exportAllData();
    return jsonEncode(data);
  }

  // Get weekly summary
  List<DailyRecord> getWeeklySummary() {
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));

    return _dailyRecords.where((record) {
      final recordDate = DateFormat('yyyy-MM-dd').parse(record.date);
      return recordDate.isAfter(weekAgo) && recordDate.isBefore(now);
    }).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  // Get monthly summary
  List<DailyRecord> getMonthlySummary() {
    final now = DateTime.now();
    final monthAgo = now.subtract(const Duration(days: 30));

    return _dailyRecords.where((record) {
      final recordDate = DateFormat('yyyy-MM-dd').parse(record.date);
      return recordDate.isAfter(monthAgo) && recordDate.isBefore(now);
    }).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }
}
