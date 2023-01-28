import 'package:flutter/material.dart';

import 'option_chip.dart';

class OptionField<T> extends StatefulWidget {
  final List<T> options;
  final T value;
  final String label;
  final Function(T value)? onChanged;
  final String Function(T value) builder;

  const OptionField({
    Key? key,
    required this.options,
    required this.value,
    required this.label,
    required this.builder,
    this.onChanged,
  }) : super(key: key);

  @override
  State<OptionField<T>> createState() => _OptionFieldState<T>();
}

class _OptionFieldState<T> extends State<OptionField<T>> {
  late T _value;

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
            for (final option in widget.options)
              OptionChip<T>(
                color: Theme.of(context).primaryColor,
                isSelected: _value == option,
                label: widget.builder(option),
                onTap: () {
                  setState(() {
                    _value = option;
                    widget.onChanged?.call(option);
                  });
                },
              ),
          ],
          spacing: 0,
          runSpacing: 0,
        ),
      ],
    );
  }
}
