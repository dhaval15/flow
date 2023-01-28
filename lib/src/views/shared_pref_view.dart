import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefView extends StatelessWidget with SharedPrefMixin {
  final SharedPreferences _preferences;
  final Widget child;

  SharedPrefView({
    required SharedPreferences preferences,
    required this.child,
  }) : this._preferences = preferences;

  factory SharedPrefView.of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<SharedPrefView>()!;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

mixin SharedPrefMixin {
  SharedPreferences get _preferences;

  String get scheme => _preferences.getString('SCHEME') ?? 'Radiant Dark';

  set scheme(String value) {
    _preferences.setString('SCHEME', value);
  }
}
