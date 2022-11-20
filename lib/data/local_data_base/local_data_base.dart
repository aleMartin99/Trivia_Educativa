// import 'dart:developer';

// import 'package:collection/collection.dart';
// import 'package:hive/hive.dart';
// import 'storable.dart';
// import 'local_data_base_contract.dart';

// show CachePolicy, LocalDatabase, TestFunction;

// class HiveLocalDataBase<T extends Storable> implements LocalDatabase<T> {
//   HiveLocalDataBase(
//     this.boxName, {
//     this.maxLength = 40,
//     this.policy = CachePolicy.FIFO,
//     this.maxDurationFile = const Duration(days: 30),
//     required this.isElementValid,
//     this.equals,
//   });

//   final String boxName;
//   final TestFunction<T> isElementValid;
//   final Duration maxDurationFile;
//   final int maxLength;

//   @override
//   final bool Function(T e1, T e2)? equals;

//   @override
//   final CachePolicy policy;

//   @override
//   Future<void> add(T element) async {
//     final box = await _getBox();
//     log('adding element $T to box');
//     try {
//       await removeWhere((e) {
//         if (equals != null) {
//           return equals!(e, element);
//         } else {
//           return e == element;
//         }
//       });
//     } catch (e) {
//       log('Error adding element $e adding element $element to box');
//       rethrow;
//     }

//     await box.add(element);
//   }

//   @override
//   Future<void> addAll(List<T> elementList) => Future.wait(elementList.map(add));

//   @override
//   Future<Iterable<T>> getAll() async {
//     return (await _getBox()).values;
//   }

//   @override
//   Future<T?> getAt(int index) async => (await _getBox()).getAt(index);
//   @override
//   Future<void> updateAt(int index, T e) async =>
//       (await _getBox()).put(index, e);

//   @override
//   Future<Iterable<T>> getInRange(int startIndex, int endIndex) async =>
//       (await _getBox()).values.skip(startIndex).take(endIndex - startIndex);

//   @override
//   Future<Iterable<T>> getWhere(TestFunction<T> test) async =>
//       (await _getBox()).values.where(test);

//   @override
//   Future<void> remove(T element) async {
//     final _box = await _getBox();
//     for (var key in _box.keys) {
//       final _elementDecoded = _box.get(key);
//       if (element == _elementDecoded) {
//         _box.delete(key);
//       }
//     }
//   }

//   @override
//   Future<void> removeAt(int index) async => (await _getBox()).deleteAt(index);

//   @override
//   Future<void> removeWhere(TestFunction<T> test) async {
//     final _box = await _getBox();

//     _box.keys.forEachIndexed((index, key) {
//       final _elementDecoded = _box.get(key);

//       if (_elementDecoded != null && test(_elementDecoded)) {
//         _box.delete(key);
//       }
//     });
//   }

//   @override
//   Future<bool> updateWhere(TestFunction<T> test, T e) async {
//     final _box = await _getBox();
//     bool match = false;
//     _box.keys.forEachIndexed((index, dynamic key) {
//       final _elementDecoded = _box.getAt(index);
//       if (_elementDecoded != null && test(_elementDecoded)) {
//         match = true;
//         _box.put(key, e);
//       }
//     });
//     return match;
//   }

//   Future<void> _validateValuesOnDataBase() async {
//     // await removeWhere(_invalidElement);
//     final _box = await Hive.openBox<T>(boxName);
//     if (_box.length > maxLength) {
//       await wipeExtraItems(_box);
//     }
//   }

//   Future<void> wipeExtraItems(Box<T> box) async {
//     switch (policy) {
//       case CachePolicy.FIFO:
//         await box.deleteAll(box.keys.take(box.keys.length - maxLength));
//         break;
//       default:
//     }
//   }

//   Future<Box<T>> _getBox() async {
//     final _box = await Hive.openBox<T>(boxName);
//     // _box.clear();
//     await _validateValuesOnDataBase();
//     return _box;
//   }

//   @override
//   Future<void> clear() => _getBox().then((value) => value.clear());

//   @override
//   Future<bool> contains(T element) async {
//     final _box = await _getBox();
//     for (var key in _box.keys) {
//       final _elementDecoded = _box.get(key);
//       if (element == _elementDecoded) {
//         return true;
//       }
//     }
//     return false;
//   }
// }
