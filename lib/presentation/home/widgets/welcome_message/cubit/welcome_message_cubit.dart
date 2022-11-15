import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kWelcomeMessageKey = 'welcomeMessage_viewed';

class WelcomeMessageCubit extends Cubit<bool> {
  final SharedPreferences _sharedPreferences;
  WelcomeMessageCubit(
    this._sharedPreferences,
    Object object,
  ) : super(_sharedPreferences.getBool(_kWelcomeMessageKey) ?? false);

  void markAsViewed() {
    _sharedPreferences.setBool(_kWelcomeMessageKey, true);
  }

  bool get alreadySeen =>
      _sharedPreferences.getBool(_kWelcomeMessageKey) ?? false;

  /// Don't know why you could want it, but it is here.
  void markAsNotViewed() =>
      _sharedPreferences.setBool(_kWelcomeMessageKey, false);
}
