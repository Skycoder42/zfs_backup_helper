abstract class Comparation<T> {
  const factory Comparation.comparator(Comparator<T> comparator, T a, T b) =
      _ComparatorComparation<T>;

  const factory Comparation.comparable(Comparable<T> comparable, T other) =
      _ComparableComparation<T>;

  int compare();
}

class CombinedComparation {
  final List<Comparation> comparations;

  const CombinedComparation(this.comparations);

  int compare() {
    for (final comparation in comparations) {
      final result = comparation.compare();
      if (result != 0) {
        return result;
      }
    }

    return 0;
  }
}

class _ComparatorComparation<T> implements Comparation<T> {
  final Comparator<T> comparator;
  final T a;
  final T b;

  const _ComparatorComparation(this.comparator, this.a, this.b);

  @override
  int compare() => comparator(a, b);
}

class _ComparableComparation<T> implements Comparation<T> {
  final Comparable<T> comparable;
  final T other;

  const _ComparableComparation(this.comparable, this.other);

  @override
  int compare() => comparable.compareTo(other);
}
