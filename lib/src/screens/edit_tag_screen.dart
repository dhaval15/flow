import 'package:flutter/material.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

const colors = [
  Colors.red,
  Colors.blue,
  Colors.amber,
  Colors.teal,
  Colors.brown,
  Colors.deepOrange,
  Colors.green,
  Colors.indigo,
  Colors.pink,
];

class EditTagScreen extends StatefulWidget {
  final Tag tag;

  const EditTagScreen({Key? key,required this.tag}) : super(key: key);

  @override
  State<EditTagScreen> createState() => _EditTagScreenState();
}

class _EditTagScreenState extends State<EditTagScreen> {
  late Tag _tag;

  @override
  void initState() {
    super.initState();
    _tag = widget.tag;
  }

  bool _validate() {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
							enabled: false,
                decoration: InputDecoration(
                  hintText: 'Name',
                ),
                onChanged: (text) {
                  _tag = _tag.copyWith(name: text);
                },
              ),
              ColorField(
                label: 'Color',
                value: Color(_tag.color),
                colors: colors,
                onChanged: (color) {
                  _tag = _tag.copyWith(color: color.value);
                },
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () {
                    if (_validate()) Navigator.of(context).pop(_tag);
                  },
                  icon: Icon(Icons.done),
                  label: Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
