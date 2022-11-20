import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotaLocalCubit extends Cubit<bool> {
  final SharedPreferences _sharedPreferences;

  NotaLocalCubit(
    this._sharedPreferences,
    Object object,
  ) : super(_sharedPreferences.getBool(_kNotaKey) ?? false);

  void markAsSavedNota() {
    _sharedPreferences.setBool(_kNotaKey, true);
  }

  bool get notaPending => _sharedPreferences.getBool(_kNotaKey) ?? false;

  /// Don't know why you could want it, but it is here.
  void markAsNotViewed() => _sharedPreferences.setBool(_kNotaKey, false);
}

const String _kNotaKey = 'nota_pending';
