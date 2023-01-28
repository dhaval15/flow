import '../models/models.dart';
import 'card_api.dart';
import 'rivulet_list_extensions.dart';
import 'tag_api.dart';

final _tags = <Tag>[
  Tag(name: 'idea', color: 0xFFF44336),
  Tag(name: 'task', color: 0xFFF44336),
  Tag(name: 'search', color: 0xFFF44336),
  Tag(name: 'short', color: 0xFFF44336),
];

class DummyTagApi implements TagApi {
  const DummyTagApi();

  Future<List<Tag>> fetch() async {
    return _tags;
  }

  Future<void> save(Tag tag) async {
    final index = _tags.indexWhere((e) => e.name == tag.name);
    if (index > 0)
      _tags[index] = tag;
    else
      _tags.insert(0, tag);
  }
}

class DummyCardApi implements CardApi {
  static final _cards = [
    Card(
      id: '0',
      tags: _tags.map((e) => e.name).toList().sublist(0,2),
      title: 'Lorem Ipsum',
      content:
          '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.''',
      createdAt: DateTime.now(),
      effort: Effort.medium,
      updatedAt: DateTime.now(),
      state: CardState.today,
    ),
    Card(
      id: '1',
      tags: _tags.map((e) => e.name).toList().sublist(1,3),
      title: 'Lorem Ipsum',
      content:
          '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.''',
      createdAt: DateTime.now(),
      effort: Effort.medium,
      updatedAt: DateTime.now(),
      state: CardState.indefinite,
    ),
    Card(
      id: '2',
      tags: [],
      title: 'Lorem Ipsum',
      content:
          '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.''',
      createdAt: DateTime.now(),
      effort: Effort.medium,
      updatedAt: DateTime.now(),
      state: CardState.later,
    ),
    Card(
      id: '3',
      title: 'Lorem Ipsum',
      tags: [],
      content:
          '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.''',
      createdAt: DateTime.now(),
      effort: Effort.medium,
      updatedAt: DateTime.now(),
      state: CardState.scheduled(DateTime.now().add(Duration(days: 10))),
    ),
    Card(
      id: '4',
      title: 'Lorem Ipsum',
      tags: [],
      content:
          '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.''',
      createdAt: DateTime.now(),
      effort: Effort.medium,
      updatedAt: DateTime.now(),
      state: CardState.deadline(DateTime.now().add(Duration(days: 10))),
    ),
  ];

  const DummyCardApi();

  Future<List<Card>> fetch([dynamic finder]) async {
    return _cards;
  }

  Future<Card> insert(Card card) async {
    final newCard = card.copyWith(id: _cards.length.toString());
    _cards.add(newCard);
    return newCard;
  }

  Future<void> update(Card card) async {
    _cards.replaceWhere(card, (e) => card.id == e.id);
  }

  @override
  Future<void> updateMultiple(List<Card> cards) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteFound(dynamic finder) {
    throw UnimplementedError();
  }
}
