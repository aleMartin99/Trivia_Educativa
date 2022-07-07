import 'dart:math';

import 'package:educational_quiz_app/core/app_routes.dart';
import 'package:educational_quiz_app/data/models/nivel_model.dart';
import 'package:educational_quiz_app/core/routers/routers.dart';
import 'package:educational_quiz_app/presentation/nivel/widgets/nivel_card/nivel_card_widget.dart';
import 'package:educational_quiz_app/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class NivelPage extends StatefulWidget {
  const NivelPage({
    Key? key,
    required this.niveles,
    required this.idTema,
    required this.idAsignatura,
    required this.idCurso,
  }) : super(key: key);
  final List<Nivel> niveles;
  final String idTema;
  final String idAsignatura;
  final String idCurso;

  @override
  _NivelPageState createState() => _NivelPageState();
}

class _NivelPageState extends State<NivelPage> {
  @override
  initState() {
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // log(controller.toString());
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    return Scaffold(
        backgroundColor:
            settingsController.currentAppTheme.scaffoldBackgroundColor,
        appBar: NewGradientAppBar(
          gradient: const LinearGradient(colors: [
            Color(0xFF57B6E0),
            Color(0xFF8257E5),
          ], stops: [
            0.0,
            0.695
          ], transform: GradientRotation(2.13959913 * pi)),
          // toolbarHeight: kToolbarHeight,
          title: const Text('Niveles'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: ListView(
            shrinkWrap: true,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
              ),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: widget.niveles
                    .map(
                      (nivel) => NivelCardWidget(
                        nombre: nivel.descripcion,
                        preguntas: nivel.preguntas,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.challengeRoute,
                            arguments: ChallengePageArgs(
                                preguntas: nivel.preguntas,
                                rango3: nivel.rango3,
                                rango4: nivel.rango4,
                                rango5: nivel.rango5,
                                quizTitle: nivel.descripcion,
                                idAsignatura: widget.idAsignatura,
                                idCurso: widget.idCurso,
                                idTema: widget.idTema,
                                idNivel: nivel.id),
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ));
  }
}
