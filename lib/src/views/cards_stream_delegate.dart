import '../screens/screens.dart';
import 'package:flutter/material.dart' hide Card;

import '../models/models.dart';
import '../views/views.dart';
import '../widgets/widgets.dart';

class CardsStreamDelegate {
  final Stream<List<Card>> stream;

  const CardsStreamDelegate(this.stream);

  Widget get widget => StreamSliverListBuilder<Card>(
	    emptyText: 'No Cards',
      padding: const EdgeInsets.all(16),
      divider: const SizedBox(height: 16),
      stream: stream,
      builder: (context, card) => CardTile(
        onTap: () {
          Navigator.of(context).pushNamed(Screens.VIEW_CARD, arguments: card);
        },
        card: card,
      ),
    );
}
