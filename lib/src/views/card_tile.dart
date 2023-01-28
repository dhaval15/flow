import 'package:flutter_neumorphic/flutter_neumorphic.dart' hide Card;

import '../models/models.dart';

class CardTile2 extends StatelessWidget {
  final Card card;
  final Color? color;
  const CardTile2({
    Key? key,
    required this.card,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(card.title),
      subtitle: Text(card.content),
      trailing: card.done ? Icon(Icons.done) : SizedBox(),
    );
  }
}

class CardTile3 extends StatelessWidget {
  final Card card;
  final Color? color;
  final GestureTapCallback? onTap;
  const CardTile3({
    Key? key,
    required this.card,
    required this.onTap,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 2,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              card.title,
              style: TextStyle(fontSize: 20),
              maxLines: 1,
            ),
            const SizedBox(height: 4),
            Text(
              card.content,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class CardTile extends StatelessWidget {
  final Card card;
  final Color? color;
  final GestureTapCallback? onTap;
  const CardTile({
    Key? key,
    required this.card,
    required this.onTap,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
	  final color = Theme.of(context).colorScheme.onBackground;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.08),
              color.withOpacity(0.05),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              card.title,
              style: TextStyle(fontSize: 20),
              maxLines: 1,
            ),
            const SizedBox(height: 4),
            Text(
              card.content,
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
