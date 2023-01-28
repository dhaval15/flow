import 'package:flutter/material.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class TagTile extends StatelessWidget {
  final Tag tag;
  final GestureTapCallback onTap;

  const TagTile({
    Key? key,
    required this.tag,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TappableContainer(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tag.name,
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 4),
          FutureWhenBuilder<int>(
            future: Providers.of<CardProvider>(context).count(tag.name),
            builder: (context, count) => Text(count.toString()),
          ),
        ],
      ),
    );
  }
}
