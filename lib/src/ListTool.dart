class ListTool {
  static bool ForAll<T>(List<T> list, bool Function(T) fn) {
    for (var item in list) {
      if (!fn(item)) return false;
    }
    return true;
  }

  static List<T> Filter<T>(List<T> list, bool Function(T) fn) {
    List<T> result = [];
    for (var item in list) {
      if(fn(item)) result.add(item);
    }
    return result;
  }

  static List<T> Flatten<T>(List<List<T>> list) {
    List<T> result = [];
    for( var item in list) {
      result.addAll(item);
    }
    return result;
  }

  static List<R> FlatMap<T, R>(List<T> list, List<R> Function(T) block) {
    List<R> result = [];
    for (var item in list) {
      result.addAll(block(item));
    }
    return result;
  }
}
