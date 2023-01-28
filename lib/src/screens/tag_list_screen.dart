import 'package:flutter/material.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../views/views.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class TagListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Providers.of<TagProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: StreamGridBuilder<Tag>(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          padding: const EdgeInsets.all(16),
          //divider: const SizedBox(height: 12),

          stream: provider.tags,
          builder: (context, tag, index) => TagTile(
            tag: tag,
            onTap: () {
              Navigator.of(context).pushNamed(Screens.TAG, arguments: tag);
            },
          ),
        ),
      ),
    );
  }
}
