import '../apis/apis.dart';
import '../models/models.dart';

class TagProvider {
  final Rivulet<List<Tag>> _rivulet;
  final TagApi _api;

  TagProvider(this._api)
      : _rivulet = Rivulet<List<Tag>>(onInit: () => _api.fetch(), data: []);

  Stream<List<Tag>> get tags => _rivulet.stream;

  Future<Tag> find(String tag) async {
    final data = await tags.first;
    return data.firstWhere((e) => e.name == tag);
  }

  void save(Tag tag) async {
    _rivulet.modify((data) async {
      await _api.save(tag);
      if (!data.replaceWhere(tag, (e) => e.name == tag.name))
        data.insert(0, tag);
    });
  }
}
