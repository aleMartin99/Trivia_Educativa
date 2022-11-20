import 'storable.dart';

enum CachePolicy { FIFO }

typedef TestFunction<T extends Storable> = bool Function(T e);

abstract class LocalDatabase<T extends Storable> {
  bool Function(T e1, T e2)? get equals;

  CachePolicy get policy;

  Future<void> add(T element);

  Future<void> clear();

  Future<void> addAll(List<T> elementList);

  Future<void> remove(T element);

  Future<void> removeWhere(TestFunction<T> test);

  Future<void> removeAt(int index);

  Future<T?> getAt(int index);

  Future<bool> contains(T element);

  Future<Iterable<T>> getInRange(int startIndex, int endIndex);

  Future<Iterable<T>> getAll();

  Future<Iterable<T>> getWhere(TestFunction<T> test);

  Future<bool> updateWhere(TestFunction<T> test, T e);

  Future<void> updateAt(int index, T e);
}
