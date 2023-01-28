export 'add_tag_sheet.dart';
import 'package:flutter/material.dart';

class Sheet {
  static var _default = _SheetConfig(
    min: 0.25,
    max: 0.25,
    initial: 0.25,
    expand: false,
  );

  static void setDefault({
    double? min,
    double? max,
    double? initial,
    bool? expand,
  }) {
    _default =
        _default.copyWith(min: min, max: max, initial: initial, expand: expand);
  }

  static _SheetConfig config({
    double? min,
    double? max,
    double? initial,
    bool? expand,
  }) =>
      _default.copyWith(min: min, max: max, initial: initial, expand: expand);

  static Future<T?> show<T>(BuildContext context, Widget sheet,
      {_SheetConfig? config}) async {
    final c = config ?? _default;
    final response = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        minChildSize: c.min,
        maxChildSize: c.max,
        initialChildSize: c.initial,
        expand: c.expand,
        builder: (context, controller) => sheet,
      ),
    );
    if (response is T) return response;
    return null;
  }
}

class _SheetConfig {
  final double min;
  final double max;
  final double initial;
  final bool expand;

  const _SheetConfig({
    required this.min,
    required this.max,
    required this.initial,
    required this.expand,
  });

  _SheetConfig copyWith({
    double? min,
    double? max,
    double? initial,
    bool? expand,
  }) =>
      _SheetConfig(
        min: min ?? this.min,
        initial: initial ?? this.initial,
        max: max ?? this.max,
        expand: expand ?? this.expand,
      );
}
