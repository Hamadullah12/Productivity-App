import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user_profile.dart';
import '../providers/app_provider.dart';
import '../main.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Hamad');
  final _universityController =
      TextEditingController(text: 'Software Engineering Student');
  final _yearController = TextEditingController(text: 'Second Year');
  final _locationController =
      TextEditingController(text: 'Peshawar, Pakistan');
  int _dailyGoal = 10;

  @override
  void dispose() {
    _nameController.dispose();
    _universityController.dispose();
    _yearController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    if (_formKey.currentState!.validate()) {
      final profile = UserProfile(
        name: _nameController.text,
        university: _universityController.text,
        year: _yearController.text,
        location: _locationController.text,
        dailyGoal: _dailyGoal,
      );

      final appProvider = context.read<AppProvider>();
      await appProvider.updateUserProfile(profile);

      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                Icon(
                  Icons.rocket_launch,
                  size: 100,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome to\nProject Focus! 🎯',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Let\'s set up your profile to get started on your productivity journey!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Your Name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _universityController,
                  decoration: InputDecoration(
                    labelText: 'University/College',
                    prefixIcon: const Icon(Icons.school),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _yearController,
                  decoration: InputDecoration(
                    labelText: 'Year/Semester',
                    prefixIcon: const Icon(Icons.calendar_today),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                    prefixIcon: const Icon(Icons.location_on),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Daily Goal: $_dailyGoal tasks',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Slider(
                  value: _dailyGoal.toDouble(),
                  min: 5,
                  max: 20,
                  divisions: 15,
                  label: _dailyGoal.toString(),
                  onChanged: (value) {
                    setState(() {
                      _dailyGoal = value.toInt();
                    });
                  },
                ),
                const SizedBox(height: 32),
                FilledButton.icon(
                  onPressed: _completeOnboarding,
                  icon: const Icon(Icons.check),
                  label: const Text('Get Started'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
