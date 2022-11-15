import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _kOnboardingKey = 'onboarding_viewed';

class OnboardingCubit extends Cubit<bool> {
  final SharedPreferences _sharedPreferences;
  OnboardingCubit(
    this._sharedPreferences,
    Object object,
  ) : super(_sharedPreferences.getBool(_kOnboardingKey) ?? false);

  void markAsViewed() {
    _sharedPreferences.setBool(_kOnboardingKey, true);
  }

  bool get alreadySeen => _sharedPreferences.getBool(_kOnboardingKey) ?? false;

  /// Don't know why you could want it, but it is here.
  void markAsNotViewed() => _sharedPreferences.setBool(_kOnboardingKey, false);
}
