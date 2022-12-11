//! ------------------------------------------
//! ---------- Error Handling Class ----------
//! ------------------------------------------

abstract class DataState<T> {
  final T? data;
  final String? error;

  DataState(this.data, this.error);
}

class DataSucsses<T> extends DataState<T> {
  DataSucsses(T? data) : super(data, null);
}

class DataFailed<T> extends DataState<T> {
  DataFailed(String error) : super(null, error);
}
