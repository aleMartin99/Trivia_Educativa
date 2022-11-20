import 'dart:math';

class AppSpunds {
  static String get nota2_1 => "assets/sounds/nota2_1.wav";
  static String get nota2_2 => "assets/sounds/nota2_2.wav";
  static String get nota2_3 => "assets/sounds/nota2_3.wav";

  static String get nota3_1 => "assets/sounds/nota3_1.mp3";
  static String get nota3_2 => "assets/sounds/nota3_2.mp3";

  static String get nota4_1 => "assets/sounds/nota4_1.mp3";

  static String get nota5_1 => "assets/sounds/nota5_1.wav";
  static String get nota5_2 => "assets/sounds/nota5_2.wav";

  static String get soundtrack_1 => "assets/sounds/soundtrack_1.mp3";
  static String get soundtrack_2 => "assets/sounds/soundtrack_2.wav";

  static final List<String> defaultSoundTracks = [
    AppSpunds.soundtrack_1,
    AppSpunds.soundtrack_2,
  ];

  static String randomSoundTrack() {
    int a = Random().nextInt(2);
    return defaultSoundTracks[a];
  }
}
