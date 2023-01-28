import 'package:flutter/material.dart';

class OptionChip<T> extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final GestureTapCallback onTap;
  final String label;

  const OptionChip({
    super.key,
    required this.color,
    required this.isSelected,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onSurface,
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
            width: 1,
          ),
          color: isSelected ? color : Colors.transparent,
        ),
      ),
    );
  }
}
