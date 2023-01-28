import 'dart:async';

import 'package:rxdart/rxdart.dart';

class Rivulet<T> {
  bool _initialized = false;
  final FutureOr<T> Function() onInit;
  late T data;
  final BehaviorSubject<T> _subject = BehaviorSubject<T>();

  Rivulet({
    required this.onInit,
    required this.data,
  });

  Stream<T> get stream {
    populate().then((_) {
      if (_) notify();
    });
    return _subject.stream;
  }

  void mutate(T Function(T old) modifier) {
    this.data = modifier(data);
    notify();
  }

  Future modify(FutureOr Function(T data) modifier) async{
    await modifier(data);
    notify();
  }

  Future<bool> populate() async {
    if (!_initialized) {
      try {
        data = await onInit();
        _initialized = true;
        return true;
      } catch (e) {
        _subject.addError(e);
      }
    }
    return false;
  }

  void populateWithData(T data) {
    this.data = data;
    _initialized = true;
  }

  void notify() {
    _subject.add(data);
  }

  void dispose() {
    _subject.close();
  }
}
