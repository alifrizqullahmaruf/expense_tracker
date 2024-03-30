import 'package:flutter/material.dart'; // Import Flutter Material package

class ChartBar extends StatelessWidget {
  const ChartBar({
    super.key,
    required this.fill,
  }); // Constructor for ChartBar widget

  final double fill; // Fill ratio for the bar

  @override
  Widget build(BuildContext context) {
    final isDarkMode = // Check if dark mode is enabled
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4), // Padding for the bar
        child: FractionallySizedBox(
          heightFactor: fill, // Height factor of the bar
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle, // Rectangle shape for the bar
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)), // Rounded corners for the bar
              color: isDarkMode
                  ? Theme.of(context).colorScheme.secondary // Bar color in dark mode
                  : Theme.of(context).colorScheme.primary.withOpacity(0.65), // Bar color in light mode
            ),
          ),
        ),
      ),
    ); // Return expanded container representing the chart bar
  }
}
