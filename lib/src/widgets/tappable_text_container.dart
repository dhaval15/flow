import 'package:flutter/material.dart';

import 'tappable_container.dart';

class TappableTextContainer extends StatelessWidget {
  final String label;
  final GestureTapCallback onTap;
  final Color? color;
  final EdgeInsets padding;

  const TappableTextContainer({
    super.key,
    required this.onTap,
    required this.label,
    this.padding = const EdgeInsets.all(16),
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TappableContainer(
      color: color,
      padding: padding,
      onTap: onTap,
      child: Text(
        label,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
