import '../apis/apis.dart';
import '../models/models.dart';

class CardProvider {
  final Rivulet<List<Card>> _rivulet;
  final CardApi _api;

  CardProvider(this._api)
      : _rivulet = Rivulet<List<Card>>(onInit: () => _api.fetch(), data: []);

  Stream<List<Card>> get cards => _rivulet.stream;

  Stream<List<Card>> get today => cards
      .map((event) => event.where((e) => e.state == CardState.today).toList());

  Stream<List<Card>> get in7Days =>
      cards.map((event) => event.where(_isIn7Days).toList());

  Stream<List<Card>> get later => cards
      .map((event) => event.where((e) => e.state == CardState.later).toList());

  Stream<List<Card>> get indefinite => cards.map(
      (event) => event.where((e) => e.state == CardState.indefinite).toList());

  Stream<List<Card>> get scheduled => cards.map(
      (event) => event.where((e) => e.state.label == 'Scheduled').toList());

  Stream<List<Card>> get deadline => cards
      .map((event) => event.where((e) => e.state.label == 'Deadline').toList());

  Stream<List<Card>> contains(String tag) =>
      cards.map((event) => event.where((e) => e.tags.contains(tag)).toList());

  Future<int> count(String tag) async {
    final data = await cards.first;
    return data.fold<int>(
        0, (total, e) => e.tags.contains(tag) ? total + 1 : total);
  }

  bool _isIn7Days(Card card) {
    if (card.state is TimedCardState) {
      final time = (card.state as TimedCardState).time;
      return time.isBefore(DateTime.now().add(Duration(days: 7)));
    }
    return false;
  }

  Future save(Card card, {bool? atEnd = false}) =>
      _rivulet.modify((data) async {
        if (card.id == null) {
          final newCard = await _api.insert(card);
          data.insert(0, newCard);
        } else {
          await _api.update(card);
          data.replaceWhere(card, (e) => card.id == e.id, atEnd: atEnd);
        }
      });
}

class FlowProvider {
  final CardProvider provider;
  final _todayFinder = Finder(
    filter: Filter.equals('state', 'Today'),
  );

  FlowProvider(this.provider);

  Future<int> countOfUndoneForToday() async {
    final cards = await provider.today.first;
    final unfinished = cards.where((card) => !card.done).toList();
    return unfinished.length;
  }

  Future<Card> toggleDone(Card card) async {
    final newCard = card.copyWith(done: !card.done);
    await provider.save(newCard, atEnd: null);
    return newCard;
  }

  void markTodayAsDone() async {
    await provider._rivulet.modify((data) async {
      final cards = await provider.today.first;
      final unfinished = cards.where((card) => !card.done).length;
      if (unfinished > 0)
        throw Exception(
            'There are $unfinished tasks which are not marked as done');
      provider._api.deleteFound(_todayFinder);
      data.removeWhere((card) => card.state == CardState.today);
    });
  }
}
