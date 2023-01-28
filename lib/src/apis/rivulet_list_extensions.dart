extension ListExtension<T> on List<T> {
  bool replaceWhere(T item, bool Function(T) predicate, {bool? atEnd}) {
    final index = indexWhere(predicate);
    if (index < 0) return false;
    removeAt(index);
    if (atEnd == null)
      insert(index, item);
    else if (atEnd)
      add(item);
    else
      insert(0, item);
    return true;
  }
}
