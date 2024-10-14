import 'dart:async';

typedef DebounceFunction<T> = Future<T> Function();

class Debouncer {
  Timer? _debounceTimer;
  Completer? _f;

  Debouncer();

  Future<T> debounce<T>({
    required DebounceFunction<T> func,
    required Duration duration,
  }) {
    _f ??= Completer<T>();
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer?.cancel();
    }
    _debounceTimer = Timer(duration, () {
      var result = func();
      _f?.complete(result);
      _f = null;
    });
    return _f!.future as Future<T>;
  }

  void dispose() {
    _debounceTimer?.cancel();
  }
}
