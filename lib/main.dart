import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/app.dart';
import 'src/providers/providers.dart';
import 'src/views/views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferences = await SharedPreferences.getInstance();
  runApp(SingleProvider<AppProvider>(
    data: AppProvider(),
    child: SharedPrefView(
      preferences: preferences,
      child: const FlowApp(),
    ),
  ));
}
