class Tag {
  final String name;
  final int color;

  const Tag({
    required this.name,
    required this.color,
  });

  factory Tag.create(String name) => Tag(
        name: name,
        color: 0xFF009688,
      );

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json['name'],
        color: json['color'],
      );

  Tag copyWith({
    String? name,
    int? color,
  }) =>
      Tag(
        name: name ?? this.name,
        color: color ?? this.color,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'color': color,
      };
}
