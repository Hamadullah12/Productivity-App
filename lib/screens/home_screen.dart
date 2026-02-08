import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';
import '../widgets/score_card.dart';
import '../widgets/focus_timer_widget.dart';
import '../widgets/add_task_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AppProvider>(
          builder: (context, appProvider, _) {
            final tasks = appProvider.tasks;
            final completedTasks = tasks.where((t) => t.isCompleted).length;
            final totalTasks = tasks.length;
            final score = totalTasks > 0
                ? (completedTasks / totalTasks * 100).round()
                : 0;

            return CustomScrollView(
              slivers: [
                // App Bar
                SliverAppBar.large(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, ${appProvider.userProfile.name}! 👋',
                        style: const TextStyle(fontSize: 20),
                      ),
                      Text(
                        DateFormat('EEEE, MMMM d').format(DateTime.now()),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                  actions: [
                    // Streak badge
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Chip(
                        avatar: const Icon(Icons.local_fire_department,
                            size: 18),
                        label: Text(
                          '${appProvider.userProfile.streakCount} day${appProvider.userProfile.streakCount != 1 ? 's' : ''}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        backgroundColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      ),
                    ),
                  ],
                ),

                // Score and efficiency cards
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ScoreCard(
                          completedTasks: completedTasks,
                          totalTasks: totalTasks,
                          efficiency: appProvider.dailyRecords.isNotEmpty
                              ? appProvider.dailyRecords.last
                                  .efficiencyPercentage
                              : 0,
                        ),
                        const SizedBox(height: 16),
                        const FocusTimerWidget(),
                      ],
                    ),
                  ),
                ),

                // Tasks header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Today\'s Tasks',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          '$completedTasks/$totalTasks',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Task list
                if (tasks.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.task_alt,
                            size: 80,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No tasks yet!',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap + to add your first task',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final task = tasks[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: TaskCard(task: task),
                          );
                        },
                        childCount: tasks.length,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const AddTaskDialog(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Task'),
      ),
    );
  }
}
