class Rating {
  final double rate;
  final int count;

  //<editor-fold desc="Data Methods">
  const Rating({required this.rate, required this.count});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Rating &&
          runtimeType == other.runtimeType &&
          rate == other.rate &&
          count == other.count);

  @override
  int get hashCode => rate.hashCode ^ count.hashCode;

  @override
  String toString() {
    return 'Rating{' + ' rate: $rate,' + ' count: $count,' + '}';
  }

  Rating copyWith({double? rate, int? count}) {
    return Rating(rate: rate ?? this.rate, count: count ?? this.count);
  }

  Map<String, dynamic> toMap() {
    return {'rate': this.rate, 'count': this.count};
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(rate: map['rate'] as double, count: map['count'] as int);
  }

  //</editor-fold>
}
