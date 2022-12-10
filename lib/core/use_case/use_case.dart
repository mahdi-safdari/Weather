//! -------------
//! (T) output -- (P) Entran
abstract class UseCase<T, P> {
  Future<T> call(P params);
}
