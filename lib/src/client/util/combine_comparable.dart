int compareAll(List<int Function()> comparators) =>
    comparators.map((c) => c()).firstWhere(
          (value) => value != 0,
          orElse: () => 0,
        );
