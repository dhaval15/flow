import '../styles/utils.dart';
import 'package:flutter/material.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';

class ExplorePage extends StatelessWidget {
  static const List<List<String>> _buttons = [
    ['Tags', Screens.TAG_LIST],
    ['Later', Screens.LATER],
    ['Indefinite', Screens.INDEFINITE],
    ['Scheduled', Screens.SCHEDULED],
    ['Due', Screens.DUE],
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('Explore'),
        ),
        Container(
          height: 88,
          child: Center(
            child: ListView.separated(
						  padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
              scrollDirection: Axis.horizontal,
              itemCount: _buttons.length,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(width: 8),
              itemBuilder: (context, index) => TappableTextContainer(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                onTap: () {
                  Navigator.of(context).pushNamed(_buttons[index][1]);
                },
                label: _buttons[index][0],
              ),
            ),
          ),
        ).sliver,
      ],
    );
  }
}
