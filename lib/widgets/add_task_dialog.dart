import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/app_provider.dart';

class AddTaskDialog extends StatefulWidget {
  const AddTaskDialog({super.key});

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedCategory = 'other';
  int? _duration;
  int? _targetValue;
  TimeOfDay? _scheduledTime;
  bool _notificationEnabled = true;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Task'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Task Title *',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.task),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Description
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),

              // Category
              Text(
                'Category',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  _CategoryChip(
                    label: 'Exercise',
                    icon: Icons.fitness_center,
                    category: 'exercise',
                    isSelected: _selectedCategory == 'exercise',
                    onSelected: () =>
                        setState(() => _selectedCategory = 'exercise'),
                  ),
                  _CategoryChip(
                    label: 'Study',
                    icon: Icons.book,
                    category: 'study',
                    isSelected: _selectedCategory == 'study',
                    onSelected: () =>
                        setState(() => _selectedCategory = 'study'),
                  ),
                  _CategoryChip(
                    label: 'Health',
                    icon: Icons.favorite,
                    category: 'health',
                    isSelected: _selectedCategory == 'health',
                    onSelected: () =>
                        setState(() => _selectedCategory = 'health'),
                  ),
                  _CategoryChip(
                    label: 'Spiritual',
                    icon: Icons.self_improvement,
                    category: 'spiritual',
                    isSelected: _selectedCategory == 'spiritual',
                    onSelected: () =>
                        setState(() => _selectedCategory = 'spiritual'),
                  ),
                  _CategoryChip(
                    label: 'Other',
                    icon: Icons.check_circle,
                    category: 'other',
                    isSelected: _selectedCategory == 'other',
                    onSelected: () =>
                        setState(() => _selectedCategory = 'other'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Duration
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Duration (minutes)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.timer),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _duration = int.tryParse(value);
                  });
                },
              ),
              const SizedBox(height: 16),

              // Target value (for exercises)
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Target Count (e.g., 15 push-ups)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.flag),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _targetValue = int.tryParse(value);
                  });
                },
              ),
              const SizedBox(height: 16),

              // Scheduled time
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.schedule),
                title: Text(
                  _scheduledTime == null
                      ? 'Set Scheduled Time'
                      : 'Scheduled: ${_scheduledTime!.format(context)}',
                ),
                trailing: _scheduledTime != null
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _scheduledTime = null;
                          });
                        },
                      )
                    : null,
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    setState(() {
                      _scheduledTime = time;
                    });
                  }
                },
              ),

              // Notification toggle
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Enable Notification'),
                value: _notificationEnabled,
                onChanged: _scheduledTime != null
                    ? (value) {
                        setState(() {
                          _notificationEnabled = value;
                        });
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _saveTask,
          child: const Text('Add Task'),
        ),
      ],
    );
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      DateTime? scheduledDateTime;
      if (_scheduledTime != null) {
        final now = DateTime.now();
        scheduledDateTime = DateTime(
          now.year,
          now.month,
          now.day,
          _scheduledTime!.hour,
          _scheduledTime!.minute,
        );
      }

      final task = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text.isEmpty
            ? null
            : _descriptionController.text,
        category: _selectedCategory,
        duration: _duration,
        targetValue: _targetValue,
        scheduledTime: scheduledDateTime,
        notificationEnabled: _notificationEnabled,
      );

      context.read<AppProvider>().addTask(task);
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Task added successfully! 🎯'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final String category;
  final bool isSelected;
  final VoidCallback onSelected;

  const _CategoryChip({
    required this.label,
    required this.icon,
    required this.category,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onSelected(),
    );
  }
}
