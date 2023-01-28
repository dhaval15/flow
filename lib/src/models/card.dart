import 'state.dart';
import 'effort.dart';

class Card {
  final String? id;
  final String title;
  final String content;
	final List<String> tags;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CardState state;
  final Effort effort;
  final bool done;

  const Card({
    this.id,
    required this.title,
    required this.content,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
    required this.state,
    required this.effort,
    this.done = false,
  });

  factory Card.create() => Card(
        content: '',
				tags: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        state: CardState.later,
        effort: Effort.medium,
				title: '',
      );

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        id: json['id'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
        state: CardState.fromJson(json['state']),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updatedAt']),
        content: json['content'],
        title: json['title'],
        effort: Effort.fromJson(json['effort']),
        tags: List.from(json['tags']),
        done: json['done'],
      );

  Card copyWith({
    String? id,
    String? content,
    String? title,
    DateTime? createdAt,
    DateTime? updatedAt,
    CardState? state,
    Effort? effort,
    List<String>? tags,
    bool? done,
  }) =>
      Card(
        id: id ?? this.id,
        content: content ?? this.content,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        state: state ?? this.state,
        effort: effort ?? this.effort,
        tags: tags ?? this.tags,
        done: done ?? this.done,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'createdAt': createdAt.millisecondsSinceEpoch,
        'updatedAt': updatedAt.millisecondsSinceEpoch,
        'state': state.toJson(),
        'effort': effort.toJson(),
        'tags': tags,
        'done': done,
        'title': title,
      };

  String get stateLabel =>
      state is TimedCardState ? (state as TimedCardState).inTime : state.label;
}
