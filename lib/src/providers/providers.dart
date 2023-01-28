export 'tag_provider.dart';
import 'package:flutter/widgets.dart';
export 'app_provider.dart';
export 'card_provider.dart';

class Providers extends StatelessWidget {
  final List _data;
  final Widget child;

  const Providers({
    required List data,
    required this.child,
  }) : this._data = data;

  static T of<T>(BuildContext context) => context
      .findAncestorWidgetOfExactType<Providers>()!
      ._data
      .whereType<T>()
      .first;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class SingleProvider<T> extends StatelessWidget {
  final T _data;
  final Widget child;

  const SingleProvider({
    required T data,
    required this.child,
  }) : this._data = data;

  static T of<T>(BuildContext context) =>
      context.findAncestorWidgetOfExactType<SingleProvider<T>>()!._data;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
