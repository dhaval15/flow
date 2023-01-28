import 'package:flutter/material.dart';

import '../models/models.dart';

class TagChip extends StatelessWidget {
  final Tag tag;

  const TagChip({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('\u2022 ${tag.name}'),
    );
  }
}
