import 'package:flutter/material.dart';

class ScoreCard extends StatelessWidget {
  final int completedTasks;
  final int totalTasks;
  final double efficiency;

  const ScoreCard({
    super.key,
    required this.completedTasks,
    required this.totalTasks,
    required this.efficiency,
  });

  @override
  Widget build(BuildContext context) {
    final scorePercentage =
        totalTasks > 0 ? (completedTasks / totalTasks * 100).round() : 0;

    return Card(
      elevation: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.secondaryContainer,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Daily Score
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.stars,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Daily Score',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$completedTasks/$totalTasks',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$scorePercentage% Complete',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                        ),
                      ],
                    ),
                  ),

                  // Efficiency
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Efficiency',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                  ),
                            ),
                            const SizedBox(width: 8),
                            Icon(
                              Icons.trending_up,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${efficiency.toStringAsFixed(0)}%',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getEfficiencyLabel(efficiency),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: totalTasks > 0 ? completedTasks / totalTasks : 0,
                  minHeight: 12,
                  backgroundColor:
                      Theme.of(context).colorScheme.surfaceVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),

              // Motivational message
              if (scorePercentage > 0) ...[
                const SizedBox(height: 12),
                Text(
                  _getMotivationalMessage(scorePercentage),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _getEfficiencyLabel(double efficiency) {
    if (efficiency >= 90) return 'Excellent! 🎉';
    if (efficiency >= 70) return 'Great! 💪';
    if (efficiency >= 50) return 'Good! 👍';
    if (efficiency >= 30) return 'Keep Going! 🚀';
    return 'You Got This! 💫';
  }

  String _getMotivationalMessage(int scorePercentage) {
    if (scorePercentage == 100) return 'Perfect day! You\'re unstoppable! 🏆';
    if (scorePercentage >= 80) return 'Amazing progress! Keep it up! ⭐';
    if (scorePercentage >= 60) return 'You\'re doing great! 🎯';
    if (scorePercentage >= 40) return 'Good start! Keep pushing! 💪';
    return 'Every task counts! You got this! 🚀';
  }
}
