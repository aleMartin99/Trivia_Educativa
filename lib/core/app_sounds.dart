import 'dart:math';

class AppSounds {
  static String get nota2_1 => "sounds/nota2_1.wav";
  static String get nota2_2 => "sounds/nota2_2.wav";
  static String get nota2_3 => "sounds/nota2_3.wav";
  static String get nota3_1 => "sounds/nota3_1.mp3";
  static String get nota3_2 => "sounds/nota3_2.mp3";
  static String get nota4_1 => "sounds/nota4_1.mp3";
  static String get nota5_1 => "sounds/nota5_1.wav";
  static String get nota5_2 => "sounds/nota5_2.wav";

  static String get soundtrack_1 => "sounds/soundtrack_1.mp3";
  static String get soundtrack_2 => "sounds/soundtrack_2.wav";

  static final List<String> defaultSoundTracks = [
    AppSounds.soundtrack_1,
    AppSounds.soundtrack_2,
  ];

  static final List<String> resultSoundNota2 = [
    AppSounds.nota2_1,
    AppSounds.nota2_2,
    AppSounds.nota2_3,
  ];

  static final List<String> resultSoundNota3 = [
    AppSounds.nota3_1,
    AppSounds.nota3_2,
  ];

  static final List<String> resultSoundNota5 = [
    AppSounds.nota5_1,
    AppSounds.nota5_2,
  ];

  static String randomResultSoundNota2() {
    int a = Random().nextInt(3);
    return resultSoundNota2[a];
  }

  static String randomResultSoundNota3() {
    int a = Random().nextInt(2);
    return resultSoundNota3[a];
  }

  static String randomResultSoundNota5() {
    int a = Random().nextInt(2);
    return resultSoundNota5[a];
  }

  static String randomSoundTrack() {
    int a = Random().nextInt(2);
    return defaultSoundTracks[a];
  }
}
