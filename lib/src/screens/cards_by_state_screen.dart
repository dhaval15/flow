import 'package:flutter/material.dart' hide Card;

import '../models/models.dart';
import '../views/views.dart';

class CardsByStateScreen extends StatelessWidget {
  final String title;
	final Stream<List<Card>> stream;

  const CardsByStateScreen({super.key, required this.title, required this.stream});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(title),
							automaticallyImplyLeading: false,
            ),
            CardsStreamDelegate(stream).widget,
          ],
        ),
      ),
    );
  }
}
