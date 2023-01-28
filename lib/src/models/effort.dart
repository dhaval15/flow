class Effort {
  final int minutes;
  final String label;

  static const values = [low, medium, high];

  static const low = Effort._(10, 'Low');
  static const medium = Effort._(50, 'Medium');
  static const high = Effort._(100, 'High');

  factory Effort.fromJson(int json) {
    if (json == 10) return low;
    if (json == 50) return medium;
    if (json == 100) return high;
    throw Exception('Can not parse $json');
  }

  const Effort._(this.minutes, this.label);
  T when<T>({
    required T Function() low,
    required T Function() medium,
    required T Function() high,
  }) {
    if (minutes == 10) return low.call();
    if (minutes == 50) return medium.call();
    if (minutes == 100) return high.call();
    throw Exception('$this is illegal state');
  }

  int toJson() => minutes;
}
