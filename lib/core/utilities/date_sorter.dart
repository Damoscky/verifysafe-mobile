class DateSorter<T> {
  //Internal storage of the original list
  final List<T> _originalList;

  //The function that extracts the date from each item
  final DateTime? Function(T item) getDate;

  //Creates an instance and stores the original list
  DateSorter({
    required List<T> list,
    required this.getDate,
  }) : _originalList = List<T>.from(list);

  //Sorts the list by date (ascending by default)
  List<T> sort({bool ascending = true}) {
    final sortedList = List<T>.from(_originalList);

    sortedList.sort((a, b) {
      final dateA = getDate(a);
      final dateB = getDate(b);

      if (dateA == null && dateB == null) return 0;
      if (dateA == null) return ascending ? 1 : -1;
      if (dateB == null) return ascending ? -1 : 1;

      return ascending ? dateA.compareTo(dateB) : dateB.compareTo(dateA);
    });

    return sortedList;
  }

  //Returns the original (unsorted) list
  List<T> clear() {
    return List<T>.from(_originalList);
  }
}
