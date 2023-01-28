import 'package:flutter/material.dart';

class ColorField extends StatefulWidget {
  final List<Color> colors;
  final Color value;
  final String label;
  final Function(Color color)? onChanged;

  const ColorField({
    Key? key,
    required this.colors,
    required this.value,
    required this.label,
    this.onChanged,
  }) : super(key: key);

  @override
  State<ColorField> createState() => _ColorFieldState();
}

class _ColorFieldState extends State<ColorField> {
  late Color _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label),
        const SizedBox(height: 12),
        Wrap(
          children: [
            for (final color in widget.colors)
              _ColorChip(
                color: color,
                isSelected: _value == color,
                onTap: () {
                  setState(() {
                    _value = color;
                    widget.onChanged?.call(color);
                  });
                },
              ),
          ],
          spacing: 4,
          runSpacing: 4,
        ),
      ],
    );
  }
}

class _ColorChip extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final GestureTapCallback? onTap;
  final double size = 20;

  const _ColorChip({
    Key? key,
    required this.color,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(size),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? theme.colorScheme.onSurface : color,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(size),
          color: color,
        ),
      ),
    );
  }
}
