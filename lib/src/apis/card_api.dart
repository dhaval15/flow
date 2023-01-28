import '../models/models.dart';
import 'sembast_api.dart';

class CardApi {
  final StoreRef<String, Map<String,dynamic>> _storeRef;

  final Database _database;

  CardApi(this._database, [String store = 'cards'])
      : _storeRef = stringMapStoreFactory.store('cards');

  Future<List<Card>> fetch([Finder? finder]) async {
    final response =
        await SembastApi.find(_database, _storeRef, finder: finder);
    return response.map((e) => Card.fromJson(e.value)).toList();
  }

  Future<Card> insert(Card card) async {
    if (card.id != null)
      throw Exception('\'id\' should be null and \'boxId\' should not be null');
    final id = await SembastApi.insert(_database, _storeRef, card.toJson());
    return card.copyWith(id: id);
  }

  Future<void> updateMultiple(List<Card> cards) async {
    //final id = await SembastApi.insert(database, storeRef, card.toJson());
    //return card.copyWith(id: id);
    throw Exception('Implement first');
  }

  Future<void> deleteFound(Finder finder) async {
    await SembastApi.deleteFound(_database, _storeRef, finder);
  }

  Future<void> update(Card card) async {
    if (card.id == null)
      throw Exception('\'id\' and \'boxId\' should not be null');
    return SembastApi.update(_database, _storeRef, card.toJson());
  }
}
