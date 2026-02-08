import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../providers/app_provider.dart';
import '../models/user_profile.dart';
import '../services/storage_service.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AppProvider>(
          builder: (context, appProvider, _) {
            final profile = appProvider.userProfile;

            return CustomScrollView(
              slivers: [
                SliverAppBar.large(
                  title: const Text('Settings'),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Profile Section
                        Text(
                          'Profile',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 12),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                ListTile(
                                  leading:
                                      const Icon(Icons.person_outline),
                                  title: const Text('Name'),
                                  subtitle: Text(profile.name),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () =>
                                        _editProfile(context, appProvider),
                                  ),
                                ),
                                ListTile(
                                  leading: const Icon(Icons.school_outlined),
                                  title: const Text('University'),
                                  subtitle: Text(profile.university),
                                ),
                                ListTile(
                                  leading:
                                      const Icon(Icons.calendar_today_outlined),
                                  title: const Text('Year'),
                                  subtitle: Text(profile.year),
                                ),
                                ListTile(
                                  leading:
                                      const Icon(Icons.location_on_outlined),
                                  title: const Text('Location'),
                                  subtitle: Text(profile.location),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Preferences Section
                        Text(
                          'Preferences',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 12),
                        Card(
                          child: Column(
                            children: [
                              SwitchListTile(
                                secondary: const Icon(Icons.dark_mode_outlined),
                                title: const Text('Dark Mode'),
                                value: profile.isDarkMode,
                                onChanged: (value) {
                                  final updatedProfile = UserProfile(
                                    name: profile.name,
                                    university: profile.university,
                                    year: profile.year,
                                    location: profile.location,
                                    isDarkMode: value,
                                    dailyGoal: profile.dailyGoal,
                                    notificationsEnabled:
                                        profile.notificationsEnabled,
                                    streakCount: profile.streakCount,
                                    lastActiveDate: profile.lastActiveDate,
                                    motivationalQuotes:
                                        profile.motivationalQuotes,
                                  );
                                  appProvider.updateUserProfile(updatedProfile);
                                },
                              ),
                              SwitchListTile(
                                secondary:
                                    const Icon(Icons.notifications_outlined),
                                title: const Text('Notifications'),
                                value: profile.notificationsEnabled,
                                onChanged: (value) {
                                  final updatedProfile = UserProfile(
                                    name: profile.name,
                                    university: profile.university,
                                    year: profile.year,
                                    location: profile.location,
                                    isDarkMode: profile.isDarkMode,
                                    dailyGoal: profile.dailyGoal,
                                    notificationsEnabled: value,
                                    streakCount: profile.streakCount,
                                    lastActiveDate: profile.lastActiveDate,
                                    motivationalQuotes:
                                        profile.motivationalQuotes,
                                  );
                                  appProvider.updateUserProfile(updatedProfile);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.flag_outlined),
                                title: const Text('Daily Goal'),
                                subtitle:
                                    Text('${profile.dailyGoal} tasks per day'),
                                trailing: IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () =>
                                      _editDailyGoal(context, appProvider),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Data Management Section
                        Text(
                          'Data Management',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 12),
                        Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.download_outlined),
                                title: const Text('Export Data'),
                                subtitle: const Text('Save as JSON'),
                                onTap: () => _exportData(context, appProvider),
                              ),
                              ListTile(
                                leading: const Icon(Icons.delete_outline),
                                title: const Text('Clear All Data'),
                                subtitle: const Text('Reset app to default'),
                                textColor: Colors.red,
                                iconColor: Colors.red,
                                onTap: () => _clearData(context),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // About Section
                        Text(
                          'About',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 12),
                        Card(
                          child: Column(
                            children: [
                              const ListTile(
                                leading: Icon(Icons.info_outline),
                                title: Text('Version'),
                                subtitle: Text('1.0.0'),
                              ),
                              ListTile(
                                leading: const Icon(Icons.code_outlined),
                                title: const Text('Built with Flutter'),
                                subtitle: const Text('Cross-platform app'),
                                onTap: () {
                                  showAboutDialog(
                                    context: context,
                                    applicationName: 'Project Focus',
                                    applicationVersion: '1.0.0',
                                    applicationIcon: const Icon(
                                      Icons.rocket_launch,
                                      size: 48,
                                    ),
                                    children: [
                                      const Text(
                                        'A productivity app designed to help software engineering students stay focused, combat distractions, and track their daily progress.',
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _editProfile(BuildContext context, AppProvider appProvider) {
    final nameController =
        TextEditingController(text: appProvider.userProfile.name);
    final universityController =
        TextEditingController(text: appProvider.userProfile.university);
    final yearController =
        TextEditingController(text: appProvider.userProfile.year);
    final locationController =
        TextEditingController(text: appProvider.userProfile.location);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: universityController,
                decoration: const InputDecoration(
                  labelText: 'University',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: yearController,
                decoration: const InputDecoration(
                  labelText: 'Year',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final profile = appProvider.userProfile;
              final updatedProfile = UserProfile(
                name: nameController.text,
                university: universityController.text,
                year: yearController.text,
                location: locationController.text,
                isDarkMode: profile.isDarkMode,
                dailyGoal: profile.dailyGoal,
                notificationsEnabled: profile.notificationsEnabled,
                streakCount: profile.streakCount,
                lastActiveDate: profile.lastActiveDate,
                motivationalQuotes: profile.motivationalQuotes,
              );
              appProvider.updateUserProfile(updatedProfile);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editDailyGoal(BuildContext context, AppProvider appProvider) {
    int dailyGoal = appProvider.userProfile.dailyGoal;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Set Daily Goal'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$dailyGoal tasks per day',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Slider(
                value: dailyGoal.toDouble(),
                min: 5,
                max: 20,
                divisions: 15,
                label: dailyGoal.toString(),
                onChanged: (value) {
                  setState(() {
                    dailyGoal = value.toInt();
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final profile = appProvider.userProfile;
                final updatedProfile = UserProfile(
                  name: profile.name,
                  university: profile.university,
                  year: profile.year,
                  location: profile.location,
                  isDarkMode: profile.isDarkMode,
                  dailyGoal: dailyGoal,
                  notificationsEnabled: profile.notificationsEnabled,
                  streakCount: profile.streakCount,
                  lastActiveDate: profile.lastActiveDate,
                  motivationalQuotes: profile.motivationalQuotes,
                );
                appProvider.updateUserProfile(updatedProfile);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _exportData(BuildContext context, AppProvider appProvider) {
    final data = appProvider.exportDataAsJson();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Data'),
        content: SingleChildScrollView(
          child: SelectableText(data),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _clearData(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Data?'),
        content: const Text(
          'This will delete all tasks, records, and journal entries. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              await StorageService.clearAllData();
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('All data cleared')),
                );
                context.read<AppProvider>().initialize();
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}
