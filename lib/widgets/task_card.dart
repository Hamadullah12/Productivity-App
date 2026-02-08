import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/app_provider.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          context.read<AppProvider>().toggleTaskCompletion(task.id);
        },
        onLongPress: () {
          _showTaskOptions(context);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Checkbox
              Checkbox(
                value: task.isCompleted,
                onChanged: (_) {
                  context.read<AppProvider>().toggleTaskCompletion(task.id);
                },
                shape: const CircleBorder(),
              ),
              const SizedBox(width: 8),

              // Task details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            decoration: task.isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: task.isCompleted
                                ? Theme.of(context).colorScheme.onSurfaceVariant
                                : null,
                          ),
                    ),
                    if (task.description?.isNotEmpty ?? false) ...[
                      const SizedBox(height: 4),
                      Text(
                        task.description!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        // Category chip
                        _CategoryChip(category: task.category),
                        const SizedBox(width: 8),

                        // Duration or target value
                        if (task.duration != null)
                          _InfoChip(
                            icon: Icons.timer,
                            label: '${task.duration} min',
                          ),
                        if (task.targetValue != null)
                          _InfoChip(
                            icon: Icons.fitness_center,
                            label: 'x${task.targetValue}',
                          ),

                        // Scheduled time
                        if (task.scheduledTime != null) ...[
                          const SizedBox(width: 8),
                          _InfoChip(
                            icon: Icons.schedule,
                            label:
                                DateFormat('h:mm a').format(task.scheduledTime!),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // More options
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => _showTaskOptions(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showTaskOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Task'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Show edit task dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit feature coming soon!')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Delete Task', style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.pop(context);
                context.read<AppProvider>().deleteTask(task.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Task deleted')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String category;

  const _CategoryChip({required this.category});

  @override
  Widget build(BuildContext context) {
    final categoryData = _getCategoryData(category);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: categoryData['color'].withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            categoryData['icon'],
            size: 14,
            color: categoryData['color'],
          ),
          const SizedBox(width: 4),
          Text(
            categoryData['label'],
            style: TextStyle(
              fontSize: 12,
              color: categoryData['color'],
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getCategoryData(String category) {
    switch (category) {
      case 'exercise':
        return {
          'icon': Icons.fitness_center,
          'label': 'Exercise',
          'color': Colors.orange,
        };
      case 'study':
        return {
          'icon': Icons.book,
          'label': 'Study',
          'color': Colors.blue,
        };
      case 'health':
        return {
          'icon': Icons.favorite,
          'label': 'Health',
          'color': Colors.green,
        };
      case 'spiritual':
        return {
          'icon': Icons.self_improvement,
          'label': 'Spiritual',
          'color': Colors.purple,
        };
      default:
        return {
          'icon': Icons.check_circle,
          'label': 'Other',
          'color': Colors.grey,
        };
    }
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
