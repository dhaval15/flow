import 'package:timeago/timeago.dart' as TimeAgo;

class CardState {
  static const today = CardState._('Today');
  static const later = CardState._('Later');
  static const indefinite = CardState._('Indefinite');

  factory CardState.scheduled(DateTime time) =>
      TimedCardState('Scheduled', time);

  factory CardState.deadline(DateTime time) => TimedCardState('Deadline', time);

  const CardState._(this._type);

  factory CardState.fromJson(dynamic json) {
    if (json == 'Today') return today;
    if (json == 'Later') return later;
    if (json == 'Indefinite') return indefinite;
    if (json['type'] == 'Scheduled')
      return CardState.scheduled(
          DateTime.fromMillisecondsSinceEpoch(json['time']));
    if (json['type'] == 'Deadline')
      return CardState.deadline(
          DateTime.fromMillisecondsSinceEpoch(json['time']));
    throw Exception('Can not parse $json');
  }

  final String _type;

  String get label => _type;

  dynamic toJson() => _type;

  T when<T>({
    required T Function() today,
    required T Function() later,
    required T Function() indefinite,
    required T Function(DateTime time) scheduled,
    required T Function(DateTime time) deadline,
  }) {
    if (_type == 'Today') return today.call();
    if (_type == 'Later') return later.call();
    if (_type == 'Indefinite') return indefinite.call();
    if (_type == 'Scheduled')
      return scheduled.call((this as TimedCardState).time);
    if (_type == 'Deadline')
      return deadline.call((this as TimedCardState).time);
    throw Exception('$this is illegal state');
  }
}

class TimedCardState extends CardState {
  final DateTime time;

  factory TimedCardState.scheduled(DateTime time) =>
      TimedCardState('Scheduled', time);

  factory TimedCardState.deadline(DateTime time) =>
      TimedCardState('Deadline', time);

  const TimedCardState(String type, this.time) : super._(type);

  TimedCardState withTime(DateTime time) => TimedCardState(this._type, time);

  String get inTime {
    if (_type == 'Scheduled')
      return 'After ${TimeAgo.format(time, allowFromNow: true)}';
    if (_type == 'Deadline')
      return 'Due ${TimeAgo.format(time, allowFromNow: true)}';
    throw Exception('$this is illegal state');
  }

  @override
  Map<String, dynamic> toJson() => {
        'type': _type,
        'time': time.millisecondsSinceEpoch,
      };
}
