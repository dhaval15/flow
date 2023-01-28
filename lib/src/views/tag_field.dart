import 'package:flutter/material.dart';

import '../sheets/sheets.dart';

class TagsView extends StatelessWidget {
  final List<String> tags;
  final Color forground;

  const TagsView({
    required this.tags,
    required this.forground,
  });

  @override
  Widget build(BuildContext context) {
    final tagBg = forground.withOpacity(0.15);
    final dotBg = forground.withOpacity(0.5);
    return Wrap(
      children: tags
          .map((tag) => Container(
                padding: EdgeInsets.only(top: 4, bottom: 4, left: 8, right: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: dotBg,
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(tag),
                  ],
                ),
                decoration: BoxDecoration(
                  color: tagBg,
                  borderRadius: BorderRadius.circular(32),
                ),
              ))
          .toList(),
      runSpacing: 4,
      spacing: 4,
    );
  }
}

class TagField extends StatefulWidget {
  final Set<String> tags;
  final Set<String> selectedTags;
  final void Function(Set<String> tags) onChanged;
  final void Function(String tag) onNewTag;

  const TagField({
    required this.tags,
    required this.selectedTags,
    required this.onChanged,
    required this.onNewTag,
  });

  @override
  _TagFieldState createState() => _TagFieldState();
}

class _TagFieldState extends State<TagField> {
  late Set<String> _tags;

  Set<String> get _unselectedTags => Set.from(widget.tags)..removeAll(_tags);

  @override
  void initState() {
    super.initState();
    _tags = Set.from(widget.selectedTags);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 6,
      spacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: _buildChips().toList(),
    );
  }

  Iterable<Widget> _buildChips() sync* {
    ColorScheme scheme = Theme.of(context).colorScheme;
    final textColor = scheme.onSurface;
    for (final tag in _tags) {
      yield ActionChip(
        elevation: 0,
        pressElevation: 1,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        label: Text(tag),
        labelStyle: TextStyle(
          color: textColor,
        ),
        onPressed: () {
          setState(() {
            _tags.remove(tag);
          });
          widget.onChanged(_tags);
        },
      );
    }
    yield ActionChip(
      onPressed: () async {
        final tag = await Sheet.show<String>(
          context,
          AddTagSheet(
            tags: _unselectedTags,
            onNewTag: widget.onNewTag,
          ),
          config: Sheet.config(min: 0.25, initial: 0.36, max: 0.7),
        );
        if (tag != null) {
          setState(() {
            _tags.add(tag);
          });
          widget.onChanged(_tags);
        }
      },
      padding: const EdgeInsets.all(0),
      labelPadding: const EdgeInsets.symmetric(horizontal: 6),
      label: const Icon(
        Icons.add,
        size: 18,
      ),
    );
  }
}
