import 'dart:async';
import 'package:sembast/sembast.dart';
export 'package:sembast/sembast.dart';

class SembastApi {
  static Future<String> insert(
      Database database, StoreRef<String, dynamic> storeRef, Map value) async {
    Completer<String> completer = Completer();
    await database.transaction((txn) async {
      String key = await storeRef.add(txn, value);
      final record = storeRef.record(key);
      await record.update(txn, {'id': key});
      completer.complete(key);
    });
    return completer.future;
  }

  static Future<void> update(
      Database database, StoreRef<String, dynamic> storeRef, Map value) async {
    final record = storeRef.record(value['id']);
    return record.update(database, value);
  }

  static Future<void> delete(
      Database database, StoreRef<String, dynamic> storeRef, String key) {
    final record = storeRef.record(key);
    return record.delete(database);
  }

  static Future<RecordSnapshot?> get(
      Database database, StoreRef<String, dynamic> storeRef, String key) {
    return storeRef.findFirst(database,
        finder: Finder(filter: Filter.byKey(key)));
  }

  static Future<List<RecordSnapshot<String,T>>> find<T>(
      Database database, StoreRef<String, T> storeRef,
      {Finder? finder}) {
    return storeRef.find(database, finder: finder);
  }

  static Future<void> deleteFound(
      Database database, StoreRef<String, dynamic> storeRef, Finder finder) {
    return storeRef.delete(database, finder: finder);
  }

  static Future<int> count(
      Database database, StoreRef<String, dynamic> storeRef,
      {required Filter filter}) {
    return storeRef.count(database, filter: filter);
  }

  static Future deleteStore(
      Database database, StoreRef<String, dynamic> storeRef) {
    return storeRef.drop(database);
  }
}
