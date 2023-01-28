import 'package:flutter/material.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

const _timelessStates = [
  CardState.today,
  CardState.later,
  CardState.indefinite
];
List<TimedCardState> get _timedStates {
  final now = DateTime.now();
  return [
    TimedCardState.scheduled(now.add(Duration(days: 7))),
    TimedCardState.deadline(now.add(Duration(days: 10))),
  ];
}

class CardStateField extends StatefulWidget {
  final CardState value;
  final String label;
  final Function(CardState value)? onChanged;

  const CardStateField({
    Key? key,
    required this.value,
    required this.label,
    this.onChanged,
  }) : super(key: key);

  @override
  State<CardStateField> createState() => _CardStateFieldState();
}

class _CardStateFieldState extends State<CardStateField> {
  late CardState _value;

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
        Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                for (final state in _timelessStates)
                  OptionChip<String>(
                    color: Theme.of(context).primaryColor,
                    isSelected: _value == state,
                    label: state.label,
                    onTap: () {
                      setState(() {
                        _value = state;
                        widget.onChanged?.call(state);
                      });
                    },
                  ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                for (final state in _timedStates)
                  OptionChip<String>(
                    color: Theme.of(context).primaryColor,
                    isSelected: _value.label == state.label,
                    label: _value is TimedCardState && _value.label == state.label
                        ? (_value as TimedCardState).inTime
                        : state.label,
                    onTap: () async {
                      final prevDate = _value is TimedCardState
                          ? (_value as TimedCardState).time
                          : DateTime.now().add(Duration(days: 7));
                      final date = await showDatePicker(
                              context: context,
                              initialDate: prevDate,
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(Duration(days: 45))) ??
                          prevDate;
                      setState(() {
                        _value = state.withTime(date);
                        widget.onChanged?.call(_value);
                      });
                    },
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

