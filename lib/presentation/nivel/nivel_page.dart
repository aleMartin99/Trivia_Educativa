import 'package:trivia_educativa/core/app_routes.dart';
import 'package:trivia_educativa/data/models/nivel_model.dart';
import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/data/models/nota_prov_model.dart';
import 'package:trivia_educativa/presentation/challenge/challenge_state.dart';
import 'package:trivia_educativa/presentation/nivel/widgets/nivel_card/nivel_card_widget.dart';
import 'package:trivia_educativa/presentation/settings/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../core/app_colors.dart';
import '../../core/app_text_styles.dart';
import '../challenge/challenge_controller.dart';
import '../shared/widgets/gradient_app_bar_widget.dart';

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
  // final controller = HomeController();
  final challengeController = ChallengeController();
  // final cont

  void _loadData() async {
    await challengeController.getNotasProv();
  }

  @override
  initState() {
    _loadData();
    // controller.stateNotifier.addListener((){
    //   setState(() {});
    // });
    challengeController.stateNotifier.addListener(() {
      if (challengeController.state == ChallengeState.notasLoaded) {
        setState(() {});
        // Future.delayed(const Duration(seconds: 1));
        // _initAnimation();
        // Dialoger.showErrorDialog(
        //   context: context,
        //   title: 'ChallengeState Listenter',
        //   description: 'ChallengeState.notasLoaded',
        // );
      }
    });
    super.initState();
  }

  //TODO ver metodo para checkear q este o no hecho el nivel
  //todo arreglar color card (dark mode check) cuando esta hecho
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
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            //TODO change to list view
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
                  if (doneLevel(
                      nivel.id, challengeController.notasProv ?? [])) {
                    return NivelCardWidget(
                      isDone: true,
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
                    );
                  } else {
                    return NivelCardWidget(
                        isDone: false,
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
                        });
                  }
                }).toList()),
          ),
        ));
  }
}
