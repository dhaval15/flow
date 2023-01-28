import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  final String tag;
  final String error;

  const ErrorContainer({Key? key, required this.tag, required this.error})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text('$tag: $error');
  }
}
