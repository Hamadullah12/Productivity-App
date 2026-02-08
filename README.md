# Project Focus 🎯

A comprehensive productivity app designed to help software engineering students stay focused, combat distractions, and track their daily progress. Built specifically for **Hamad**, a second-year software engineering student in Peshawar, Pakistan.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web%20%7C%20Desktop-green.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

## ✨ Features

### 📝 Core Functionality
- **Daily Task Checklist**: Track your daily routine with customizable tasks
- **Default Tasks Inspired by Daily Routine**:
  - 15 Push-ups 💪
  - 6-minute Meditation 🧘
  - 1-minute Plank 🏋️
  - 6 Hours Study 📚
  - Watch Informative Video 📺
  - No Junk Food 🥗
  - Pray 🙏
  - Attend Classes 🎓
  - 5 Pull-ups 🏃
  - Plan Next Day 📅
- **Fully Customizable**: Add, edit, delete tasks, set durations, goals, and scheduled times
- **Task Categories**: Exercise, Study, Health, Spiritual, Other (with color-coded badges)

### 📊 Scoring & Analytics
- **Daily Score**: Auto-calculated (completed tasks / total tasks)
- **Efficiency Percentage**: Based on completion rate and focus time
- **Streak Tracking**: Consecutive days of activity
- **Weekly & Monthly Summaries**: Visual progress with charts
- **Beautiful Charts**: Bar charts for weekly progress, line charts for monthly efficiency

### 🔔 Notifications & Reminders
- **Task Reminders**: Push notifications for scheduled tasks
- **Daily Reset**: Midnight notification for new day
- **Motivational Quotes**: Automatic encouragement when score improves
- **Pakistan Standard Time**: Timezone support for PKT
- **Cross-platform Notifications**: Works on mobile and desktop

### 🎯 Anti-Distraction Features
- **Focus Mode Timer**: Pomodoro-style sessions (25/5/15/50 minutes)
- **Focus Time Tracking**: Daily focus minutes logged
- **Overthinking Journal**: Note-taking section to clear your mind
- **Mood Tracking**: Log thoughts with emotional context (Happy, Neutral, Stressed, Motivated)

### 👤 User Profile & Customization
- **Onboarding**: First-time setup with name, university, year, location
- **Dark/Light Mode**: Material You theming with smooth transitions
- **Daily Goals**: Set custom task completion targets
- **Data Export**: Export all data as JSON for analysis
- **Motivational Badges**: Streak fire badges and progress indicators

### 💾 Data Storage
- **Local-First**: Hive database for offline persistence
- **No Internet Required**: Fully functional offline
- **Data Export**: CSV/JSON export capability
- **Privacy**: All data stored locally on device

### 🎨 UI/UX
- **Material Design 3**: Modern, clean interface
- **Gradient Score Cards**: Beautiful visual feedback
- **Emoji Support**: Motivational emojis throughout
- **Responsive Design**: Works on phones, tablets, and desktop
- **Smooth Animations**: Polished transitions and micro-interactions
- **Accessibility**: Large text support, voice-over ready

---

## 🚀 Getting Started

### Prerequisites

1. **Install Flutter** (Latest stable version)
   ```bash
   # Check Flutter installation
   flutter doctor
   ```

2. **Platform-Specific Requirements**:
   - **Android**: Android Studio with Android SDK (API 21+)
   - **iOS**: Xcode 14+ (macOS only)
   - **Web**: Chrome browser
   - **Desktop**: 
     - Windows: Visual Studio 2022 with C++ tools
     - macOS: Xcode
     - Linux: Required libraries (see Flutter docs)

---

## 📦 Installation & Build Instructions

### 1. Clone/Download the Project

Navigate to `d:\PRODUCTIVITY APP\` (the project is already there!)

### 2. Get Dependencies

Open terminal in the project directory and run:

```bash
flutter pub get
```

This will download all required packages:
- Hive (local storage)
- Provider (state management)
- FL Chart (beautiful charts)
- Flutter Local Notifications
- Intl (date formatting)
- And more!

---

## ▶️ Running the App

### 🤖 Android (Emulator or Physical Device)

1. **Start Android Emulator** or connect your Android phone via USB (with USB debugging enabled)

2. **Check Connected Devices**:
   ```bash
   flutter devices
   ```

3. **Run the App**:
   ```bash
   flutter run
   ```

   Or specify the device:
   ```bash
   flutter run -d <device-id>
   ```

4. **Build APK** (for sharing):
   ```bash
   flutter build apk --release
   ```
   APK will be at: `build/app/outputs/flutter-apk/app-release.apk`

---

### 🍎 iOS (Simulator or Physical Device - macOS Only)

1. **Install CocoaPods** (if not installed):
   ```bash
   sudo gem install cocoapods
   ```

2. **Start iOS Simulator**:
   ```bash
   open -a Simulator
   ```

3. **Run the App**:
   ```bash
   flutter run
   ```

4. **Build IPA** (for physical device):
   ```bash
   flutter build ios --release
   ```

---

### 🌐 Web (Browser)

1. **Run in Chrome**:
   ```bash
   flutter run -d chrome
   ```

2. **Build for Web Hosting**:
   ```bash
   flutter build web --release
   ```
   Output will be in: `build/web/`

3. **Serve Locally** (for testing):
   ```bash
   # Using Python
   cd build/web
   python -m http.server 8000
   ```
   Then open: `http://localhost:8000`

---

### 🖥️ Desktop

#### Windows
```bash
flutter run -d windows
```

**Build Release**:
```bash
flutter build windows --release
```
Executable: `build/windows/runner/Release/project_focus.exe`

#### macOS
```bash
flutter run -d macos
```

**Build Release**:
```bash
flutter build macos --release
```
App bundle: `build/macos/Build/Products/Release/project_focus.app`

#### Linux
```bash
flutter run -d linux
```

**Build Release**:
```bash
flutter build linux --release
```
Executable: `build/linux/x64/release/bundle/project_focus`

---

## 🛠️ Development Mode

For hot reload during development:

```bash
flutter run
```

- Press `r` to hot reload
- Press `R` to hot restart
- Press `q` to quit

---

## 📱 Platform-Specific Notes

### Android Notifications
- Minimum SDK: 21 (Android 5.0)
- Notifications work out of the box
- No additional permissions needed for local notifications

### iOS Notifications
- Requires user permission (requested on first launch)
- Configure notification settings in app Settings

### Web Limitations
- Notifications may be limited (browser-dependent)
- No background notifications
- Focus timer works perfectly

### Desktop Notifications
- Windows: Native notifications supported
- macOS: Native notifications with permission
- Linux: Depends on notification daemon

---

## 🔧 Troubleshooting

### Issue: "Hive not initialized"
**Solution**: The app auto-initializes Hive. If you see errors, try:
```bash
flutter clean
flutter pub get
flutter run
```

### Issue: Notifications not working
**Solution**: 
- Check device notification settings
- For iOS/macOS: Grant permission when prompted
- For Android: Check Do Not Disturb mode

### Issue: Build errors
**Solution**:
```bash
# Clean build cache
flutter clean

# Get dependencies
flutter pub get

# Rebuild
flutter run
```

### Issue: Charts not displaying
**Solution**: Ensure you have completed at least one task so data exists for charts.

---

## 📂 Project Structure

```
lib/
├── main.dart                 # App entry point, navigation
├── models/
│   ├── task.dart            # Task data model
│   ├── daily_record.dart    # Daily progress records
│   ├── user_profile.dart    # User settings & profile
│   └── journal_entry.dart   # Journal/overthinking notes
├── providers/
│   └── app_provider.dart    # State management (Provider pattern)
├── screens/
│   ├── onboarding_screen.dart     # First-time setup
│   ├── home_screen.dart          # Today's tasks & score
│   ├── progress_screen.dart      # Charts & analytics
│   ├── journal_screen.dart       # Overthinking journal
│   └── settings_screen.dart      # User preferences
├── services/
│   ├── storage_service.dart      # Hive database operations
│   └── notification_service.dart # Push notifications
└── widgets/
    ├── task_card.dart           # Task item display
    ├── score_card.dart          # Daily score widget
    ├── focus_timer_widget.dart  # Pomodoro timer
    └── add_task_dialog.dart     # Add new task form
```

---

## 🎯 Usage Guide

### First Launch
1. Enter your name (default: Hamad)
2. Set university, year, location (default: Peshawar, Pakistan)
3. Choose daily goal (5-20 tasks)
4. Click "Get Started"

### Adding Tasks
1. Tap the "+" button on Home screen
2. Fill in task details:
   - Title (required)
   - Description (optional)
   - Category (Exercise, Study, Health, etc.)
   - Duration in minutes
   - Target count (for exercises)
   - Scheduled time
   - Enable/disable notification
3. Save!

### Using Focus Mode
1. On Home screen, see "Focus Mode" card
2. Choose timer: 25 min (work), 5 min (break), 15 min, or 50 min
3. Timer starts immediately
4. Focus time is tracked for efficiency calculation

### Tracking Progress
1. Go to "Progress" tab
2. View weekly bar chart (last 7 days)
3. View monthly efficiency line chart
4. See stats: Streak, Focus Time, Completed Tasks, Average Score

### Journaling
1. Go to "Journal" tab
2. Tap "+" to add entry
3. Write your thoughts
4. Choose mood (Happy, Neutral, Stressed, Motivated)
5. Swipe left to delete entries

### Export Data
1. Go to Settings
2. Tap "Export Data"
3. Copy JSON output
4. Save to file for analysis

---

## 🚧 TODO: Advanced Features (For Future Development)

```dart
// TODO: AI-suggested tasks based on completion patterns
// TODO: Integration with Google Calendar for class schedules
// TODO: Habit tracking with streaks for individual tasks
// TODO: Social features: Share progress with friends
// TODO: Cloud sync with Firebase (optional login)
// TODO: Widgets for Android/iOS home screen
// TODO: Smart notifications based on historical completion times
// TODO: Study timer with subject categorization
// TODO: Break reminders with stretching suggestions
// TODO: Weekly/monthly reports as PDF
// TODO: Integration with fitness apps for exercise tasks
// TODO: Voice input for quick task addition
// TODO: Biometric lock for journal privacy
// TODO: Themes: More color schemes
// TODO: Customizable motivational quotes
```

---

## 📊 Technical Specifications

- **Flutter Version**: 3.0+ (latest stable)
- **Dart Version**: 3.0+
- **State Management**: Provider pattern
- **Database**: Hive (NoSQL, local)
- **Charts**: FL Chart
- **Notifications**: flutter_local_notifications
- **Date/Time**: intl, timezone
- **Architecture**: Clean architecture with separation of concerns
- **Design Pattern**: MVVM (Model-View-ViewModel)

---

## 🌍 Timezone Support

The app is configured for **Pakistan Standard Time (PKT)** / **Asia/Karachi** timezone:
- All scheduled notifications respect PKT
- Daily reset at midnight PKT
- Date formatting in local time

To change timezone, edit `lib/services/notification_service.dart`:
```dart
tz.setLocalLocation(tz.getLocation('Asia/Karachi')); // Change this
```

---

## ⚠️ Edge Cases Handled

1. **Incomplete Days**: Tasks carry over, daily record saved
2. **Timezone Changes**: All times calculated in PKT
3. **Low Battery**: Notifications scheduled even when app closed
4. **Data Loss Prevention**: Hive auto-saves on every change
5. **First Launch**: Default tasks auto-created
6. **Empty States**: Helpful messages with icons
7. **Streak Reset**: Breaks if >1 day gap
8. **Offline Mode**: Fully functional without internet
9. **Long Task Lists**: Scrollable with performance optimization
10. **Duplicate Prevention**: Unique IDs using timestamps

---

## 🎨 Customization Tips

### Change Primary Color
In `lib/main.dart`:
```dart
colorScheme: ColorScheme.fromSeed(
  seedColor: Colors.deepPurple, // Change this to any color!
  brightness: Brightness.light,
),
```

### Add More Default Tasks
In `lib/providers/app_provider.dart`, method `_initializeDefaultTasks()`, add:
```dart
Task(
  id: (DateTime.now().millisecondsSinceEpoch + 10).toString(),
  title: 'Your New Task',
  category: 'study',
),
```

### Modify Motivational Quotes
In `lib/models/user_profile.dart`, edit `motivationalQuotes` list.

---

## 📄 License

MIT License - Feel free to use, modify, and distribute!

---

## 👨‍💻 For Hamad

This app is designed specifically for you to:
- ✅ Combat distractions and overthinking
- ✅ Track your daily routine systematically
- ✅ Build consistency with streak tracking
- ✅ Visualize your progress over time
- ✅ Stay motivated with automated encouragement
- ✅ Manage study, exercise, health, and spiritual goals

**Remember**: Consistency is key! Use this app daily, track everything, and watch your productivity soar! 🚀

Good luck with your software engineering studies in Peshawar! 🎓💪

---

## 📞 Support

For issues, feature requests, or questions:
1. Check this README first
2. Review the TODO comments in the code
3. Modify and extend as needed - the code is well-commented!

---

## 🙏 Acknowledgments

Built with ❤️ using Flutter and designed for students who want to maximize their productivity while maintaining balance in life.

**Key Technologies**:
- Flutter & Dart
- Hive (Local Database)
- Provider (State Management)
- FL Chart (Data Visualization)
- Flutter Local Notifications

---

**Version**: 1.0.0  
**Last Updated**: February 2026  
**Built For**: Hamad - Software Engineering Student, Peshawar, Pakistan

---

## 🚀 Quick Start Commands

```bash
# Get dependencies
flutter pub get

# Run on Android
flutter run

# Run on Chrome
flutter run -d chrome

# Build release APK
flutter build apk --release

# Run with hot reload
flutter run
```

**Now go build something amazing! 💪🎯🚀**
