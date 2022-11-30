import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';
import 'package:trivia_educativa/presentation/settings/settings_imports.dart';

import '../../core/theme/text_theme.dart';
import '../home/home_controller.dart';
import '../shared/shared_imports.dart';
import '/../core/core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'nivel_imports.dart';

class NivelPage extends StatefulWidget {
  const NivelPage({
    Key? key,
    required this.niveles,
    required this.tema,
    required this.asignatura,
    required this.idEstudiante,
    required this.notas,
  }) : super(key: key);
  final List<Nivel> niveles;
  final Tema tema;
  final Asignatura asignatura;
  final String idEstudiante;
  final List<NotaProv> notas;

  @override
  _NivelPageState createState() => _NivelPageState();
}

class _NivelPageState extends State<NivelPage> {
  final challengeController = ChallengeController();
  final homeController = HomeController();

  @override
  initState() {
    challengeController.stateNotifier.addListener(() {
      if (challengeController.state == ChallengeState.notasLoaded) {
        setState(() {});
      }
    });
    super.initState();
  }

  bool doneLevel(String idNivel, List<NotaProv> notasProv) {
    bool isDone = false;
    if ((notasProv
        .where((notaProv) =>
            notaProv.nivel.where((nivel) => nivel.id == idNivel).isNotEmpty)
        .isNotEmpty)) isDone = true;

    return isDone;
  }

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          child: GradientAppBarWidget(
            child: Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          alignment: Alignment.centerLeft,
                          splashColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          padding: const EdgeInsets.all(0),
                          icon: Icon(
                            Icons.arrow_back,
                            size: 25,
                            color: settingsController
                                .currentAppTheme.iconTheme.color,
                          )),
                      Text(
                        widget.tema.descripcion,
                        style: AppTextStyles.titleBold.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          preferredSize: const Size.fromHeight(56),
        ),
//TODO make validation for data to all pages like asignatura(home)
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.0, left: 2),
                child: Text(
                  I10n.of(context).levelS,
                  style: AppTextStyles.titleBold.copyWith(
                    color: Theme.of(context).primaryIconTheme.color,
                    fontSize: 24,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: ListView(
                    shrinkWrap: true,
                    clipBehavior: Clip.antiAlias,
                    itemExtent: 120,
                    physics: const BouncingScrollPhysics(),
                    children: widget.niveles.map((nivel) {
                      if (doneLevel(nivel.id, widget.notas)) {
                        return NivelCardWidget(
                          isDone: true,
                          duracion: nivel.duracion,
                          nombre: nivel.descripcion,
                          preguntas: nivel.preguntas,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.challengeRoute,
                              arguments: ChallengePageArgs(
                                preguntas: nivel.preguntas,
                                idEstudiante: widget.idEstudiante,
                                nota5: nivel.nota5,
                                quizTitle: nivel.descripcion,
                                asignatura: widget.asignatura,
                                idTema: widget.tema.id,
                                nivel: nivel,
                              ),
                            );
                          },
                        );
                      } else {
                        return NivelCardWidget(
                            duracion: nivel.duracion,
                            isDone: false,
                            nombre: nivel.descripcion,
                            preguntas: nivel.preguntas,
                            onTap: () async {
                              (nivel.preguntas.isEmpty)
                                  ? QuickAlert.show(
                                      context: context,
                                      type: QuickAlertType.warning,
                                      title: I10n.of(context)
                                          .noQuestionsDialogTitle,
                                      confirmBtnText: I10n.of(context).ok,
                                      text: I10n.of(context)
                                          .noQuestionsDialogBody,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      textColor: Theme.of(context)
                                          .primaryIconTheme
                                          .color!,
                                      titleColor: Theme.of(context)
                                          .primaryIconTheme
                                          .color!,
                                      confirmBtnColor: AppColors.purple,
                                    )
                                  : Navigator.pushNamed(
                                      context,
                                      AppRoutes.challengeRoute,
                                      arguments: ChallengePageArgs(
                                          preguntas: nivel.preguntas,
                                          idEstudiante: widget.idEstudiante,
                                          nota5: nivel.nota5,
                                          quizTitle: nivel.descripcion,
                                          asignatura: widget.asignatura,
                                          idTema: widget.tema.id,
                                          nivel: nivel),
                                    );
                            });
                      }
                    }).toList()),
              ),
            ],
          ),
        ));
  }
}
