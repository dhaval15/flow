import 'package:flutter/material.dart';

import '../styles/styles.dart';
import '../widgets/widgets.dart';
import '../views/views.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = SharedPrefView.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              DropdownField(
                label: 'Theme',
                options: Schemes.all.map((e) => e.name).toList(),
                value: SchemeProvider.of(context).scheme.name,
                onChanged: (text) {
                  SchemeProvider.of(context).scheme = Schemes.withName(text);
                  prefs.scheme = text;
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
