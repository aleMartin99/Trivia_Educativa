import 'dart:developer';

import 'package:educational_quiz_app/core/app_routes.dart';
import 'package:educational_quiz_app/core/core.dart';
import 'package:educational_quiz_app/data/models/asingatura_model.dart';
import 'package:educational_quiz_app/data/models/tema_model.dart';
import 'package:educational_quiz_app/data/models/user_model.dart';
import 'package:educational_quiz_app/core/routers/routers.dart';
import 'package:educational_quiz_app/domain/repositories/home_repository.dart';
import 'package:educational_quiz_app/presentation/home/home_controller.dart';
import 'package:educational_quiz_app/presentation/home/home_state.dart';
import 'package:educational_quiz_app/presentation/home/widgets/appbar/app_bar_widget.dart';
import 'package:educational_quiz_app/presentation/nivel/nivel_page.dart';
// import 'package:educational_quiz_app/presentation/home/widgets/level_button/level_button_widget.dart';
import 'package:educational_quiz_app/presentation/tema/widgets/tema_card/tema_card_widget.dart';
import 'package:educational_quiz_app/presentation/settings/settings_controller.dart';
import 'package:educational_quiz_app/presentation/tema/tema_controller.dart';
import 'package:educational_quiz_app/presentation/tema/tema_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:http/http.dart' as http;

class TemaPage extends StatefulWidget {
  const TemaPage({
    Key? key,
    required this.temas,
  }) : super(key: key);
  final List<Tema> temas;
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
//todo fucking gradient
        appBar: AppBar(
          toolbarHeight: kToolbarHeight,
          title: const Text('Temas'),
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
                          log('entro al on tap de temacardwidget');
                          Navigator.pushNamed(
                            context,
                            AppRoutes.nivelRoute,
                            arguments: NivelPageArgs(niveles: tema.niveles),
                          );
                        }))
                    .toList(),
              ),
            ],
          ),
        ));
  }
}
