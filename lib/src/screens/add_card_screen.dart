import '../styles/utils.dart';
import 'package:flutter/material.dart' hide Card;

import '../models/models.dart';
import '../providers/providers.dart';
import '../views/views.dart';
import '../widgets/widgets.dart';

class AddCardScreen extends StatefulWidget {
  final Card? card;

  const AddCardScreen({Key? key, this.card}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  late Card _card;
  late ValidationController _controller;

  @override
  void initState() {
    _card = widget.card ?? Card.create();
    _controller = ValidationController([
      () => Validators._title(_card.title),
      () => Validators._tags(_card.tags),
      () => Validators._content(_card.content),
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Providers.of<TagProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomScrollView(
            slivers: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Title',
                ),
                controller: TextEditingController(text: _card.title),
                onChanged: (text) {
                  _card = _card.copyWith(title: text);
                },
              ).sliver,
              const SizedBox(height: 16).sliver,
              FutureWhenBuilder<List<Tag>>(
                  future: provider.tags.first,
                  builder: (context, tags) {
                    return TagField(
                      tags: tags.map((e) => e.name).toSet(),
                      selectedTags: _card.tags.toSet(),
                      onNewTag: (name) async {
                        final tag = Tag.create(name);
                        provider.save(tag);
                      },
                      onChanged: (tags) {
                        _card = _card.copyWith(tags: tags.toList());
                      },
                    );
                  }).sliver,
              const SizedBox(height: 16).sliver,
              TextField(
                //expands: true,
                maxLines: 16,
                minLines: null,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  hintText: 'Content',
                  contentPadding: const EdgeInsets.all(8),
                ),
                controller: TextEditingController(text: _card.content),
                onChanged: (text) {
                  _card = _card.copyWith(content: text);
                },
              ).sliver,
              const SizedBox(height: 16).sliver,
              CardStateField(
                label: 'State',
                value: _card.state,
                onChanged: (value) {
                  _card = _card.copyWith(state: value);
                },
              ).sliver,
              const SizedBox(height: 16).sliver,
              OptionField<Effort>(
                options: Effort.values,
                builder: (value) => value.when(
                  low: () => 'Low',
                  medium: () => 'Medium',
                  high: () => 'High',
                ),
                label: 'Effort',
                value: _card.effort,
                onChanged: (value) {
                  _card = _card.copyWith(effort: value);
                },
              ).sliver,
              const SizedBox(height: 16).sliver,
              ValidationInfoView(
                controller: _controller,
                builder: (_, error) => Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              ).sliver,
              const SizedBox(height: 16).sliver,
              Align(
                alignment: Alignment.centerRight,
                child: MaterialButton(
                  onPressed: () {
                    if (_controller.validate())
                      Navigator.of(context).pop(_card);
                  },
                  child: Text('Save'),
                ),
              ).sliver,
              const SizedBox(height: 32).sliver,
            ],
          ),
        ),
      ),
    );
  }
}

class Validators {
  static String? _content(String text) {
    if (text.length < 21) return 'Content should be longer than 20 characters';
    return null;
  }

  static String? _title(String? text) {
    if (text != null && text.length < 3)
      return 'Title should be longer than 2 characters';
    return null;
  }

  static String? _tags(List<String> tags) {
    if (tags.isEmpty) return 'Atleast add one tag';
    return null;
  }
}
