import 'package:flutter/material.dart' hide Card;

import '../models/models.dart';
import '../providers/providers.dart';
import '../views/views.dart';
import 'screens.dart';

class TagScreen extends StatelessWidget {
  final Tag tag;

  const TagScreen({Key? key, required this.tag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Providers.of<CardProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(tag.name),
							automaticallyImplyLeading: false,
            ),
            CardsStreamDelegate(provider.contains(tag.name)).widget,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final card = await Navigator.of(context).pushNamed(Screens.ADD_CARD,
              arguments: Card.create().copyWith(tags: [tag.name]));
          if (card is Card) provider.save(card);
        },
      ),
    );
  }
}
