import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<AppProvider>(
          builder: (context, appProvider, _) {
            final weeklySummary = appProvider.getWeeklySummary();
            final monthlySummary = appProvider.getMonthlySummary();

            return CustomScrollView(
              slivers: [
                SliverAppBar.large(
                  title: const Text('Progress & Analytics'),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Stats cards
                        Row(
                          children: [
                            Expanded(
                              child: _StatCard(
                                icon: Icons.local_fire_department,
                                label: 'Streak',
                                value:
                                    '${appProvider.userProfile.streakCount} days',
                                color: Colors.orange,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _StatCard(
                                icon: Icons.timer,
                                label: 'Focus Time',
                                value: weeklySummary.isNotEmpty
                                    ? '${weeklySummary.fold<int>(0, (sum, r) => sum + r.focusMinutes)} min'
                                    : '0 min',
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _StatCard(
                                icon: Icons.check_circle,
                                label: 'Completed',
                                value: monthlySummary.isNotEmpty
                                    ? '${monthlySummary.fold<int>(0, (sum, r) => sum + r.completedTasks)} tasks'
                                    : '0 tasks',
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _StatCard(
                                icon: Icons.trending_up,
                                label: 'Avg Score',
                                value: monthlySummary.isNotEmpty
                                    ? '${(monthlySummary.fold<double>(0, (sum, r) => sum + r.scorePercentage) / monthlySummary.length).toStringAsFixed(0)}%'
                                    : '0%',
                                color: Colors.purple,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 32),

                        // Weekly completion chart
                        Text(
                          'Weekly Progress',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: SizedBox(
                              height: 200,
                              child: weeklySummary.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No data yet. Start completing tasks!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    )
                                  : BarChart(
                                      BarChartData(
                                        alignment:
                                            BarChartAlignment.spaceAround,
                                        maxY: 100,
                                        barTouchData: BarTouchData(
                                          enabled: true,
                                          touchTooltipData:
                                              BarTouchTooltipData(
                                            getTooltipItem:
                                                (group, groupIndex, rod, rodIndex) {
                                              final record =
                                                  weeklySummary[groupIndex];
                                              return BarTooltipItem(
                                                '${record.scorePercentage.toStringAsFixed(0)}%\n${record.completedTasks}/${record.totalTasks}',
                                                const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        titlesData: FlTitlesData(
                                          show: true,
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              getTitlesWidget:
                                                  (value, meta) {
                                                if (value.toInt() >=
                                                        weeklySummary.length ||
                                                    value.toInt() < 0) {
                                                  return const Text('');
                                                }
                                                final date = DateFormat('yyyy-MM-dd')
                                                    .parse(weeklySummary[
                                                            value.toInt()]
                                                        .date);
                                                return Text(
                                                  DateFormat('E')
                                                      .format(date)
                                                      .substring(0, 1),
                                                  style: const TextStyle(
                                                      fontSize: 12),
                                                );
                                              },
                                            ),
                                          ),
                                          leftTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              reservedSize: 40,
                                              getTitlesWidget:
                                                  (value, meta) {
                                                return Text(
                                                  '${value.toInt()}%',
                                                  style: const TextStyle(
                                                      fontSize: 10),
                                                );
                                              },
                                            ),
                                          ),
                                          topTitles: const AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false),
                                          ),
                                          rightTitles: const AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false),
                                          ),
                                        ),
                                        borderData: FlBorderData(show: false),
                                        barGroups: weeklySummary
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          return BarChartGroupData(
                                            x: entry.key,
                                            barRods: [
                                              BarChartRodData(
                                                toY: entry
                                                    .value.scorePercentage,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary,
                                                width: 20,
                                                borderRadius:
                                                    const BorderRadius.vertical(
                                                  top: Radius.circular(4),
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Monthly efficiency chart
                        Text(
                          'Monthly Efficiency',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: SizedBox(
                              height: 200,
                              child: monthlySummary.isEmpty
                                  ? Center(
                                      child: Text(
                                        'No data yet. Keep going!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    )
                                  : LineChart(
                                      LineChartData(
                                        gridData: FlGridData(show: true),
                                        titlesData: FlTitlesData(
                                          bottomTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              reservedSize: 30,
                                              getTitlesWidget:
                                                  (value, meta) {
                                                if (value.toInt() >=
                                                        monthlySummary
                                                            .length ||
                                                    value.toInt() < 0) {
                                                  return const Text('');
                                                }
                                                final date = DateFormat('yyyy-MM-dd')
                                                    .parse(monthlySummary[
                                                            value.toInt()]
                                                        .date);
                                                return Text(
                                                  DateFormat('d')
                                                      .format(date),
                                                  style: const TextStyle(
                                                      fontSize: 10),
                                                );
                                              },
                                            ),
                                          ),
                                          leftTitles: AxisTitles(
                                            sideTitles: SideTitles(
                                              showTitles: true,
                                              reservedSize: 40,
                                              getTitlesWidget:
                                                  (value, meta) {
                                                return Text(
                                                  '${value.toInt()}%',
                                                  style: const TextStyle(
                                                      fontSize: 10),
                                                );
                                              },
                                            ),
                                          ),
                                          topTitles: const AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false),
                                          ),
                                          rightTitles: const AxisTitles(
                                            sideTitles:
                                                SideTitles(showTitles: false),
                                          ),
                                        ),
                                        borderData: FlBorderData(show: true),
                                        lineBarsData: [
                                          LineChartBarData(
                                            spots: monthlySummary
                                                .asMap()
                                                .entries
                                                .map((entry) {
                                              return FlSpot(
                                                entry.key.toDouble(),
                                                entry.value
                                                    .efficiencyPercentage,
                                              );
                                            }).toList(),
                                            isCurved: true,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            barWidth: 3,
                                            dotData: FlDotData(show: true),
                                            belowBarData: BarAreaData(
                                              show: true,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary
                                                  .withOpacity(0.1),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
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
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
