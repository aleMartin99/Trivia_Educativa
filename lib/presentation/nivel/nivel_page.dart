import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_imports.dart';
import 'package:trivia_educativa/presentation/settings/settings_imports.dart';
import '../shared/shared_imports.dart';
import '/../core/core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'nivel_imports.dart';

class NivelPage extends StatefulWidget {
  const NivelPage({
    Key? key,
    required this.niveles,
    required this.idTema,
    required this.idAsignatura,
    required this.idEstudiante,
  }) : super(key: key);
  final List<Nivel> niveles;
  final String idTema;
  final String idAsignatura;
  final String idEstudiante;

  @override
  _NivelPageState createState() => _NivelPageState();
}

class _NivelPageState extends State<NivelPage> {
  final challengeController = ChallengeController();

  void _loadData() async {
    //await challengeController.getNotasProv();
  }

  @override
  initState() {
    //TODO check notaProv
    //  _loadData();

    challengeController.stateNotifier.addListener(() {
      if (challengeController.state == ChallengeState.notasLoaded) {
        setState(() {});
      }
    });
    super.initState();
  }

//TODO fix method doneLevel
  bool doneLevel(String idNivel, List<NotaProv> notasProv) {
    bool isDone = false;
    if ((notasProv
        .where((notaProv) =>
            notaProv.nivel?.where((nivel) => nivel.id == idNivel).isNotEmpty ??
            false)
        .isNotEmpty)) isDone = true;

    return isDone;
  }

  @override
  Widget build(BuildContext context) {
    // log(controller.toString());
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          child: GradientAppBarWidget(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  //crossAxisAlignment: CrossAxisAlignment.start,
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
                      I10n.of(context).levels,
                      style: AppTextStyles.titleBold.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          preferredSize: const Size.fromHeight(56),
        ),
//TODO make validation for data to all pages like asignatura(home)
//TODO change app bar to sliver
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: ListView(
                // padding: EdgeInsets.only(bottom: 15),
                clipBehavior: Clip.antiAlias,
                // useMagnifier: true,
                itemExtent: 120,
                physics: const BouncingScrollPhysics(),
                // shrinkWrap: true,
                // crossAxisCount: 2,
                // crossAxisSpacing: 16,
                // mainAxisSpacing: 16,
                children: widget.niveles.map((nivel) {
                  //TODO check with nuevas notasProv
                  //TODO check is done level with notasProv, llamar methodo en init state cargar notasProv
                  // if (doneLevel(
                  //     nivel.id, challengeController.notasProv ?? [])) {
                  //   return NivelCardWidget(
                  //     isDone: true,
                  //     nombre: nivel.descripcion,
                  //     preguntas: nivel.preguntas,
                  //     onTap: () {
                  //       Navigator.pushNamed(
                  //         context,
                  //         AppRoutes.challengeRoute,
                  //         arguments: ChallengePageArgs(
                  //             preguntas: nivel.preguntas,
                  //             idEstudiante: widget.idEstudiante,
                  //             nota5: nivel.nota5,
                  //             quizTitle: nivel.descripcion,
                  //             idAsignatura: widget.idAsignatura,
                  //             idTema: widget.idTema,
                  //             idNivel: nivel.id),
                  //       );
                  //     },
                  //   );
                  // } else {
                  return NivelCardWidget(
                      isDone: false,
                      nombre: nivel.descripcion,
                      preguntas: nivel.preguntas,
                      onTap: () {
                        //TODO CHECK SI CONEXION A INTERNET, EN CASO DE Q NO QUICK ALERT Y PAL LOGIN
                        Navigator.pushNamed(
                          context,
                          AppRoutes.challengeRoute,
                          arguments: ChallengePageArgs(
                              preguntas: nivel.preguntas,
                              idEstudiante: widget.idEstudiante,
                              nota5: nivel.nota5,
                              quizTitle: nivel.descripcion,
                              idAsignatura: widget.idAsignatura,
                              idTema: widget.idTema,
                              idNivel: nivel.id),
                        );
                      });
                  //}
                }).toList()),
          ),
        ));
  }
}
