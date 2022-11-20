import 'dart:math';

class AppImages {
  static String get check => "assets/images/check.png";
  static String get error => "assets/images/error.png";
  static String get trophy => "assets/images/trophy.png";
  static String get logo => "assets/images/icon_app.png";
  static String get colorfulLogo => "assets/images/colorful_logo.png";
  static String get badResult => "assets/images/bad-review.png";
  static String get mediumResult => "assets/images/positive-vote.png";
  static String get avatar => "assets/images/avatar_default.png";

  static String get tema_1 => "assets/images/tema_1.jpg";
  static String get tema_2 => "assets/images/tema_2.jpg";
  static String get tema_3 => "assets/images/tema_3.jpg";
  static String get tema_4 => "assets/images/tema_4.jpg";
  static String get tema_5 => "assets/images/tema_5.jpg";
  static String get tema_6 => "assets/images/tema_6.jpg";
  static String get tema_7 => "assets/images/tema_7.jpg";
  static String get tema_8 => "assets/images/tema_8.jpg";
  static String get tema_9 => "assets/images/tema_9.jpg";
  static String get tema_10 => "assets/images/tema_10.jpg";
  static String get tema_11 => "assets/images/tema_11.jpg";
  static String get tema_12 => "assets/images/tema_12.jpg";

//*Images por onboarding
  static String get onBoarding_1 =>
      'assets/onboarding/onboarding-navegacion.svg';
  static String get onBoarding_2 =>
      'assets/onboarding/onboarding-enseñanza-trad.svg';
  static String get onBoarding_3 => 'assets/onboarding/onboarding-notas.svg';

  static final List<String> defaultImages = [
    AppImages.tema_1,
    AppImages.tema_2,
    AppImages.tema_3,
    AppImages.tema_4,
    AppImages.tema_5,
    AppImages.tema_6,
    AppImages.tema_7,
    AppImages.tema_8,
    AppImages.tema_9,
    AppImages.tema_10,
    AppImages.tema_11,
    AppImages.tema_12,
  ];

  static String randomTema() {
    int a = Random().nextInt(12);
    return defaultImages[a];
  }
}
