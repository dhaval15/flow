import '../models/models.dart';

import '../providers/providers.dart';
import 'add_card_screen.dart';
import 'cards_by_state_screen.dart';
import 'edit_tag_screen.dart';
import 'tag_list_screen.dart';
import 'tag_screen.dart';
import 'home_screen.dart';
import 'package:flutter/material.dart' hide Card;

import 'view_card_screen.dart';

typedef ScreenBuilder = Widget Function(
    BuildContext context, Object? arguments);

class ScreenRouteGenerator {
  final Map<String, ScreenBuilder> overrides;
  final Map<String, String> redirects;

  const ScreenRouteGenerator({
    this.overrides = const {},
    this.redirects = const {},
  });

  static Map<String, ScreenBuilder> _routes = {
    Screens.HOME: (_, arguments) => HomeScreen(),
    Screens.TAG_LIST: (_, arguments) => TagListScreen(),
    Screens.TAG: (_, arguments) => TagScreen(tag: arguments as Tag),
    Screens.EDIT_TAG: (_, arguments) => EditTagScreen(tag: arguments as Tag),
    Screens.VIEW_CARD: (_, arguments) =>
        ViewCardScreen(card: arguments as Card),
    Screens.ADD_CARD: (_, arguments) => AddCardScreen(card: arguments as Card),
    Screens.EDIT_CARD: (_, arguments) => AddCardScreen(card: arguments as Card),
    Screens.LATER: (context, arguments) => CardsByStateScreen(
        title: 'Later', stream: Providers.of<CardProvider>(context).later),
    Screens.INDEFINITE: (context, arguments) => CardsByStateScreen(
        title: 'Indefinite', stream: Providers.of<CardProvider>(context).indefinite),
    Screens.SCHEDULED: (context, arguments) => CardsByStateScreen(
        title: 'Scheduled', stream: Providers.of<CardProvider>(context).scheduled),
    Screens.DUE: (context, arguments) => CardsByStateScreen(
        title: 'Due', stream: Providers.of<CardProvider>(context).deadline),
  };

  ScreenBuilder? _find(String? name) {
    final override = overrides[name];
    if (override != null) return override;
    final redirect = redirects[name];
    if (redirect != null) return _routes[redirect];
    return _routes[name];
  }

  MaterialPageRoute call(RouteSettings settings) {
    final builder = _find(settings.name);
    if (builder != null) {
      return MaterialPageRoute(
          builder: (context) => builder(context, settings.arguments));
    }
    throw Exception('${settings.name} route not found');
  }
}

class Screens {
  static const HOME = '/';
  static const EDIT_TAG = '/edit_tag';
  static const ADD_CARD = '/add_card';
  static const VIEW_CARD = '/view_card';
  static const EDIT_CARD = '/edit_card';
  static const TAG_LIST = '/tag_list';
  static const TAG = '/tag';
  static const CARD_LIST = '/card_list';
  static const LATER = '/later';
  static const INDEFINITE = '/indefinite';
  static const SCHEDULED = '/scheduled';
  static const DUE = '/due';
}
