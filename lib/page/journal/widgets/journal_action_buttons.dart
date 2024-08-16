import 'package:flutter/material.dart';

class ActionButtonConfig {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color color;

  ActionButtonConfig({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.color,
  });
}

class JournalActionButtons extends StatelessWidget {
  final List<ActionButtonConfig> buttonConfigs;

  const JournalActionButtons({
    super.key,
    required this.buttonConfigs,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: buttonConfigs.map((config) {
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0),
              child: _buildActionButton(
                context,
                icon: config.icon,
                label: config.label,
                onPressed: config.onPressed,
                color: config.color,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    required Color color,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
      ),
    );
  }
}