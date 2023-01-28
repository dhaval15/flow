import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ValidationInfoView extends StatefulWidget {
  final ValidationController controller;
  final Widget Function(BuildContext context, String error) builder;

  const ValidationInfoView({
    Key? key,
    required this.controller,
    required this.builder,
  }) : super(key: key);

  @override
  State<ValidationInfoView> createState() => _ValidationInfoViewState();
}

class _ValidationInfoViewState extends State<ValidationInfoView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String?>(
      stream: widget.controller._controller.stream,
      builder: (context, snapshot) =>
          snapshot.hasData ? widget.builder(context,snapshot.data!) : SizedBox(),
    );
  }

  @override
  void dispose() {
    widget.controller._close();
    super.dispose();
  }
}

typedef Validator = String? Function();

class ValidationController {
  final List<Validator> validators;
  final _controller = StreamController<String?>();

  ValidationController(this.validators);

  bool validate() {
    for (final validator in validators) {
      final error = validator();
      if (error != null) {
        _controller.add(error);
        return false;
      }
    }
    _controller.add(null);
    return true;
  }

  void _close() {
    _controller.close();
  }
}
