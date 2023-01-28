import 'package:flutter/material.dart';

import '../providers/providers.dart';
import '../views/views.dart';

class TodayPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Providers.of<CardProvider>(context);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('Today'),
          actions: [
            IconButton(
              onPressed: () {
                Providers.of<FlowProvider>(context).markTodayAsDone();
              },
              icon: Icon(Icons.done),
            ),
          ],
        ),
        CardsStreamDelegate(provider.today).widget,
        SliverAppBar(
          title: Text('In 7 days'),
        ),
        CardsStreamDelegate(provider.in7Days).widget,
      ],
    );
  }
}
