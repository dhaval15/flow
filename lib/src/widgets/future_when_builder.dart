import 'package:flutter/material.dart';
import 'loading_indicator.dart';

class FutureWhenBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final String? errorText;
  final Widget Function(BuildContext context, T data) builder;
  final Widget loading;

  const FutureWhenBuilder({
    Key? key,
    required this.future,
    required this.builder,
    this.errorText,
    this.loading = const Center(
      child: BouncingDotsIndiactor(),
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      builder: (context, snapshot) {
        if (snapshot.hasData) return builder(context, snapshot.data!);
        if (snapshot.hasError)
          return Center(
            child: Text(errorText ?? 'Something Went Wrong ${snapshot.error}'),
          );
        return loading;
      },
      future: future,
    );
  }
}
