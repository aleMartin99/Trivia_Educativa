import 'dart:math';
import 'package:educational_quiz_app/core/app_routes.dart';
import 'package:educational_quiz_app/data/models/tema_model.dart';
import 'package:educational_quiz_app/core/routers/routers.dart';
// import 'package:educational_quiz_app/presentation/home/widgets/level_button/level_button_widget.dart';
import 'package:educational_quiz_app/presentation/tema/widgets/tema_card/tema_card_widget.dart';
import 'package:educational_quiz_app/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:provider/provider.dart';

// import 'package:http/http.dart' as http;

class TemaPage extends StatefulWidget {
  const TemaPage({
    Key? key,
    required this.temas,
    required this.idAsignatura,
    required this.idCurso,
  }) : super(key: key);
  final List<Tema> temas;
  final String idAsignatura;
  final String idCurso;
  @override
  _TemaPageState createState() => _TemaPageState();
}

class _TemaPageState extends State<TemaPage> {
  @override
  initState() {
    setState(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Temas'),
      ),
      body: (widget.temas.isNotEmpty)
          ? Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    //*info:  botones de dificultad
                  ),
                  GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    //*info cambie el ! de temas
                    //TODO ver como controlar q no se parta, poner imagenes de que si no hay elementos...

                    children: widget.temas
                        .map((tema) => TemaCardWidget(
                            nombre: tema.descripcion,
                            cantNiveles: tema.niveles.length,
                            onTap: () {
                              //  log('id del tema desde tema page ${tema.id}');
                              Navigator.pushNamed(
                                context,
                                AppRoutes.nivelRoute,
                                arguments: NivelPageArgs(
                                    niveles: tema.niveles,
                                    idAsignatura: widget.idAsignatura,
                                    idCurso: widget.idCurso,
                                    idTema: tema.id),
                              );
                            }))
                        .toList(),
                  ),
                ],
              ),
            )
          : const Text('No hay Data disponible'),
    );
  }
}
