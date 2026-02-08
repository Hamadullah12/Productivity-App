import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:async';

import 'providers/app_provider.dart';
import 'services/storage_service.dart';
// import 'services/notification_service.dart';  // Temporarily disabled
import 'screens/home_screen.dart';
import 'screens/progress_screen.dart';
import 'screens/journal_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Open boxes without type adapters (using dynamic for simplicity)
  await Hive.openBox('tasks');
  await Hive.openBox('daily_records');
  await Hive.openBox('user_profile');
  await Hive.openBox('journal_entries');

  // Initialize notifications - Temporarily disabled
  // await NotificationService.initialize();
  // await NotificationService.requestPermissions();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider()..initialize(),
      child: Consumer<AppProvider>(
        builder: (context, appProvider, _) {
          return MaterialApp(
            title: 'Project Focus',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.light,
              ),
              cardTheme: CardThemeData(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.deepPurple,
                brightness: Brightness.dark,
              ),
              cardTheme: CardThemeData(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            themeMode: appProvider.userProfile.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            home: appProvider.isLoading
                ? const SplashScreen()
                : StorageService.getUserProfile() == null
                    ? const OnboardingScreen()
                    : const MainScreen(),
          );
        },
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.rocket_launch,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              'Project Focus',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  Timer? _focusTimer;

  final List<Widget> _screens = [
    const HomeScreen(),
    const ProgressScreen(),
    const JournalScreen(),
    const SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _startFocusTimerListener();
  }

  void _startFocusTimerListener() {
    _focusTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final appProvider = context.read<AppProvider>();
      if (appProvider.isFocusMode) {
        appProvider.tickFocusTimer();
      }
    });
  }

  @override
  void dispose() {
    _focusTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Today',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book),
            label: 'Journal',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
