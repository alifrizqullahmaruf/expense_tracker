import 'package:expense_tracker/Widget/chart/chart_bar.dart'; // Import ChartBar widget
import 'package:expense_tracker/model/expense.dart'; // Import Expense model
import 'package:flutter/material.dart'; // Import Flutter Material package

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses}); // Constructor for Chart widget

  final List<Expense> expenses; // List of expenses

  // Method to get buckets of expenses for different categories
  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food), // Get food expenses
      ExpenseBucket.forCategory(expenses, Category.leisure), // Get leisure expenses
      ExpenseBucket.forCategory(expenses, Category.travel), // Get travel expenses
      ExpenseBucket.forCategory(expenses, Category.work), // Get work expenses
    ];
  }

  // Method to get the maximum total expense among all buckets
  double get maxTotalExpense {
    double maxTotalExpense = 0; // Initialize maximum total expense

    for (final bucket in buckets) { // Iterate through each bucket
      if (bucket.totalExspenses > maxTotalExpense) { // If bucket's total expense is greater than current maximum
        maxTotalExpense = bucket.totalExspenses; // Update maximum total expense
      }
    }

    return maxTotalExpense; // Return maximum total expense
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = // Check if dark mode is enabled
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16), // Container margin
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ), // Container padding
      width: double.infinity, // Container width
      height: 180, // Container height
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8), // Container border radius
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3), // Gradient colors
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ), // Container decoration
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // Iterate through each bucket
                  ChartBar(
                    fill: bucket.totalExspenses == 0
                        ? 0
                        : bucket.totalExspenses / maxTotalExpense, // Fill ratio for ChartBar
                  )
              ],
            ),
          ), // Expanded row for ChartBars
          const SizedBox(height: 12), // SizedBox for spacing
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4), // Padding for icons
                      child: Icon(
                        categoryIcons[bucket.category], // Icon for each category
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary // Icon color in dark mode
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7), // Icon color in light mode
                      ),
                    ),
                  ),
                )
                .toList(),
          ) // Row for category icons
        ],
      ),
    ); // Return container with chart representation
  }
}
