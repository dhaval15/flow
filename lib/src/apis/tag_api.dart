import '../models/models.dart';
import 'sembast_api.dart';

class TagApi {
  final StoreRef<String, Map<String,dynamic>> _storeRef;

  final Database _database;

  TagApi(this._database, [String store = 'tags'])
      : _storeRef = stringMapStoreFactory.store('tags');

  Future<List<Tag>> fetch() async {
    final response =
        await SembastApi.find(_database, _storeRef);
    return response.map((e) => Tag.fromJson(e.value)).toList();
  }

  Future<void> save(Tag tag) async {
    await SembastApi.insert(_database, _storeRef, tag.toJson());
  }
}
