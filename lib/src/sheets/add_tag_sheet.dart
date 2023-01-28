import 'package:flutter/material.dart';

class AddTagSheet extends StatefulWidget {
  final Set<String> tags;
  final void Function(String tag) onNewTag;

  const AddTagSheet({
    required this.tags,
    required this.onNewTag,
  });

  @override
  _AddTagSheetState createState() => _AddTagSheetState();
}

class _AddTagSheetState extends State<AddTagSheet> {
  final _formKey = GlobalKey<FormState>();
  String _tag = '';
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
			  crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add Tag',
            style: theme.textTheme.headline6,
          ),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: TextEditingController(text: _tag),
              validator: (text) {
                if (text!.trim().length < 3)
                  return 'Must be longer than 2 characters';
                final value = text.trim().toLowerCase();
                return widget.tags
                        .where((tag) => tag.toLowerCase() == value)
                        .isEmpty
                    ? null
                    : '$text already exist';
              },
              onSaved: (text) {
                _tag = text!;
              },
              decoration: InputDecoration(labelText: 'Name'),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            runSpacing: 4,
            spacing: 4,
            children: [
              for (final tag in widget.tags)
                ActionChip(
                  elevation: 0,
                  pressElevation: 1,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  label: Text(tag),
                  labelStyle: TextStyle(
                    color: theme.colorScheme.onSurface,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(tag);
                  },
                ),
            ],
          ),
          const SizedBox(height: 32),
          Align(
            alignment: Alignment.centerRight,
            child: MaterialButton(
              child: Text('Add'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.onNewTag(_tag);
                  Navigator.of(context).pop(_tag);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
