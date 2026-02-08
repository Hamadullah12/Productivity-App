import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../models/journal_entry.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AppProvider>(
          builder: (context, appProvider, _) {
            final entries = appProvider.journalEntries;

            return CustomScrollView(
              slivers: [
                SliverAppBar.large(
                  title: const Text('Overthinking Journal 📝'),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.lightbulb,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Clear Your Mind',
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
                              'Write down your thoughts, worries, or ideas to help reduce overthinking and stay focused on what matters.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (entries.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.auto_stories,
                            size: 80,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No journal entries yet',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tap + to add your first entry',
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
                          final entry = entries[index];
                          return Dismissible(
                            key: Key(entry.id),
                            background: Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              child: const Icon(Icons.delete,
                                  color: Colors.white),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) {
                              appProvider.deleteJournalEntry(entry.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Entry deleted'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            },
                            child: Card(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: InkWell(
                                onTap: () {
                                  _showEntryDialog(context, entry);
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _getMoodEmoji(entry.mood),
                                            style:
                                                const TextStyle(fontSize: 24),
                                          ),
                                          Text(
                                            DateFormat('MMM d, yyyy • h:mm a')
                                                .format(entry.createdAt),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                        ],
                                      ),
                                      if (entry.title.isNotEmpty) ...[
                                        const SizedBox(height: 8),
                                        Text(
                                          entry.title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ],
                                      const SizedBox(height: 8),
                                      Text(
                                        entry.content,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: entries.length,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEntryDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('New Entry'),
      ),
    );
  }

  String _getMoodEmoji(String mood) {
    switch (mood) {
      case 'happy':
        return '😊';
      case 'stressed':
        return '😰';
      case 'motivated':
        return '💪';
      default:
        return '😐';
    }
  }

  void _showEntryDialog(BuildContext context, JournalEntry entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Text(_getMoodEmoji(entry.mood)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                entry.title.isEmpty ? 'Journal Entry' : entry.title,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                DateFormat('MMMM d, yyyy • h:mm a').format(entry.createdAt),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              Text(entry.content),
            ],
          ),
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

  void _showAddEntryDialog(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    String selectedMood = 'neutral';

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('New Journal Entry'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title (optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  labelText: 'What\'s on your mind?',
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              Text(
                'How are you feeling?',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              StatefulBuilder(
                builder: (context, setState) => Wrap(
                  spacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('😊 Happy'),
                      selected: selectedMood == 'happy',
                      onSelected: (selected) {
                        setState(() => selectedMood = 'happy');
                      },
                    ),
                    ChoiceChip(
                      label: const Text('😐 Neutral'),
                      selected: selectedMood == 'neutral',
                      onSelected: (selected) {
                        setState(() => selectedMood = 'neutral');
                      },
                    ),
                    ChoiceChip(
                      label: const Text('😰 Stressed'),
                      selected: selectedMood == 'stressed',
                      onSelected: (selected) {
                        setState(() => selectedMood = 'stressed');
                      },
                    ),
                    ChoiceChip(
                      label: const Text('💪 Motivated'),
                      selected: selectedMood == 'motivated',
                      onSelected: (selected) {
                        setState(() => selectedMood = 'motivated');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              if (contentController.text.isNotEmpty) {
                final entry = JournalEntry(
                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                  title: titleController.text,
                  content: contentController.text,
                  mood: selectedMood,
                );
                context.read<AppProvider>().addJournalEntry(entry);
                Navigator.pop(dialogContext);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
