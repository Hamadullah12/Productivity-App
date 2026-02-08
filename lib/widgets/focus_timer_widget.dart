import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class FocusTimerWidget extends StatelessWidget {
  const FocusTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, _) {
        final isFocusMode = appProvider.isFocusMode;
        final secondsRemaining = appProvider.focusSecondsRemaining;
        final minutes = secondsRemaining ~/ 60;
        final seconds = secondsRemaining % 60;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.psychology,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Focus Mode',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const Spacer(),
                    if (!isFocusMode)
                      Text(
                        '${appProvider.totalFocusMinutesToday} min today',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                  ],
                ),
                const SizedBox(height: 16),

                if (isFocusMode) ...[
                  // Active timer display
                  Center(
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 4,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                          style:
                              Theme.of(context).textTheme.headlineLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () {
                      appProvider.stopFocusMode();
                    },
                    icon: const Icon(Icons.stop),
                    label: const Text('Stop Focus Mode'),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ] else ...[
                  // Start focus mode buttons
                  Text(
                    'Pomodoro Timer - Stay focused, avoid distractions',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _TimerButton(
                        label: '25 min',
                        icon: Icons.work,
                        minutes: 25,
                        color: Colors.deepPurple,
                      ),
                      _TimerButton(
                        label: '5 min',
                        icon: Icons.coffee,
                        minutes: 5,
                        color: Colors.green,
                      ),
                      _TimerButton(
                        label: '15 min',
                        icon: Icons.browser_not_supported,
                        minutes: 15,
                        color: Colors.orange,
                      ),
                      _TimerButton(
                        label: '50 min',
                        icon: Icons.rocket_launch,
                        minutes: 50,
                        color: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TimerButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final int minutes;
  final Color color;

  const _TimerButton({
    required this.label,
    required this.icon,
    required this.minutes,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonalIcon(
      onPressed: () {
        context.read<AppProvider>().startFocusMode(minutes);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Focus mode started for $minutes minutes! 🎯'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: FilledButton.styleFrom(
        backgroundColor: color.withOpacity(0.2),
        foregroundColor: color,
      ),
    );
  }
}
