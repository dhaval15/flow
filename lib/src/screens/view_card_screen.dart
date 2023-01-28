import 'package:flutter/material.dart' hide Card;
import '../providers/providers.dart';
import '../styles/utils.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class ViewCardScreen extends StatefulWidget {
  final Card card;

  const ViewCardScreen({Key? key, required this.card}) : super(key: key);

  @override
  State<ViewCardScreen> createState() => _ViewCardScreenState();
}

class _ViewCardScreenState extends State<ViewCardScreen> {
  late Card _card;

  @override
  void initState() {
    _card = widget.card;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            if (_card.title != null)
              SliverAppBar(
                title: Text(_card.title!),
                automaticallyImplyLeading: false,
              ),
            Text('${_card.effort.label}  |  ${_card.stateLabel}')
                .padding
                .sliver,
            SizedBox(height: 12).sliver,
            TagsView(
              forground:
                  Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
              tags: _card.tags,
            ).padding.sliver,
            SizedBox(height: 12).sliver,
            Text(_card.content).padding.sliver,
            SizedBox(height: 24).sliver,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MaterialButton(
                  child: Text('Edit'),
                  onPressed: () async {
                    final newCard = await Navigator.of(context)
                        .pushNamed(Screens.ADD_CARD, arguments: _card);
                    if (newCard is Card) {
                      Providers.of<CardProvider>(context).save(newCard);
                      setState(() {
                        _card = newCard;
                      });
                    }
                  },
                ),
                MaterialButton(
                  child: Text(_card.done ? 'Mark as not Done' : 'Mark as Done'),
                  onPressed: () async {
                    final newCard = await Providers.of<FlowProvider>(context)
                        .toggleDone(_card);
                    setState(() {
                      _card = newCard;
                    });
                  },
                ),
              ],
            ).padding.sliver,
          ],
        ),
      ),
    );
  }
}
