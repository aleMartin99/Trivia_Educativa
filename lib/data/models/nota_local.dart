// import '../local_data_base/storable.dart';

// class OnboardingCubit extends Cubit<bool> {
//   final SharedPreferences _sharedPreferences;
//   OnboardingCubit(
//     this._sharedPreferences,
//     Object object,
//   ) : super(_sharedPreferences.getBool(_kOnboardingKey) ?? false);

//   void markAsViewed() {
//     _sharedPreferences.setBool(_kOnboardingKey, true);
//   }

//   bool get alreadySeen => _sharedPreferences.getBool(_kOnboardingKey) ?? false;

//   /// Don't know why you could want it, but it is here.
//   void markAsNotViewed() => _sharedPreferences.setBool(_kOnboardingKey, false);
// }

class NotaLocal {
  NotaLocal({
    required this.idAsignatura,
    required this.idEstudiante,
    required this.idNivel,
    required this.idNotaProv,
    required this.idTema,
    required this.nota,
  });
  final String? idNotaProv;
  final String? idAsignatura;
  final String? idTema;
  final String? idNivel;
  final String? idEstudiante;
  final int? nota;
}
  
//const bool _kPendingNotaKey = false;

// abstract class NotaLocal extends Storable {
//   NotaLocal(
//     this.idAsignatura,
//     this.idEstudiante,
//     this.idNivel,
//     this.idNotaProv,
//     this.idTema,
//     this.nota, {
//     DateTime? createdAt,
//     DateTime? updatedAt,
//   }) : super(
//           '($idNotaProv) $idNivel',
//           createdAt ?? DateTime.now(),
//           updatedAt ?? DateTime.now(),
//         );
//   String? idNotaProv;
//   String? idAsignatura;
//   String? idTema;
//   String? idNivel;
//   String? idEstudiante;
//   int? nota;

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is NotaLocal &&
//         other.idAsignatura == idAsignatura &&
//         other.idEstudiante == idEstudiante &&
//         other.idNivel == idNivel &&
//         other.idNotaProv == idNotaProv &&
//         other.idTema == idTema &&
//         other.nota == nota;
//   }
// }
