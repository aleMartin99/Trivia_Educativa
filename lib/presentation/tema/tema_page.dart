import 'dart:math';

import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:provider/provider.dart';

import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/settings/settings_imports.dart';
import 'tema_imports.dart';
import '/../core/core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TemaPage extends StatefulWidget {
  const TemaPage({
    Key? key,
    required this.temas,
    required this.idAsignatura,
    required this.idEstudiante,
  }) : super(key: key);
  final List<Tema> temas;
  final String idAsignatura;
  //TODO pasArS asignaura completa para coger nombre y ID
  final String idEstudiante;

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
    bool _pinned = true;
    bool _snap = false;
    bool _floating = true;
    return Scaffold(
        //TODO change app bar to sliver
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // appBar: PreferredSize(
        //   child: GradientAppBarWidget(
        //     child: Align(
        //       alignment: Alignment.bottomLeft,
        //       child: Padding(
        //         padding: const EdgeInsets.only(bottom: 6),
        //         child: Row(
        //           //crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             IconButton(
        //                 onPressed: () => Navigator.of(context).pop(),
        //                 alignment: Alignment.centerLeft,
        //                 splashColor: Colors.transparent,
        //                 hoverColor: Colors.transparent,
        //                 highlightColor: Colors.transparent,
        //                 padding: const EdgeInsets.all(0),
        //                 icon: Icon(
        //                   Icons.arrow_back,
        //                   size: 25,
        //                   color:
        //                       settingsController.currentAppTheme.iconTheme.color,
        //                 )),
        //             Text(
        //               I10n.of(context).topics,
        //               style: AppTextStyles.titleBold.copyWith(
        //                 color: AppColors.white,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ),
        //   preferredSize: const Size.fromHeight(56),
        // ),

        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              //stretch: false,
              automaticallyImplyLeading: false,
              // backgroundColor: ,
              // backgroundColor: AppColors.purple,
              expandedHeight: 220,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                        //TODO poner nombre asignaura
                        Text(
                          'Historia de Cuba',
                          style: AppTextStyles.titleBold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              pinned: _pinned,
              floating: true,
              flexibleSpace: Container(
                padding: const EdgeInsets.only(top: 106),
                //margin: EdgeInsets.all(0),
                //  height: 2500,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Theme.of(context).brightness == Brightness.light
                        ? AppColors.purple
                        : const Color.fromARGB(153, 81, 6, 255),
                    const Color(0xFF57B6E0),
                  ], stops: const [
                    0.0,
                    1.0
                  ], transform: const GradientRotation(2.13959913 * pi)),
                ),
                child: FlexibleSpaceBar(
                  //   collapseMode: CollapseMode.pin,
                  background: GlassImage(
                    // height: 200,
                    width: double.infinity,
                    blur: 2,
                    image: Image.asset(
                      'assets/images/temas.jpg',
                      fit: BoxFit.cover,
                    ),
                    overlayColor: Colors.white.withOpacity(0.1),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.2),
                        Colors.blue.withOpacity(0.3),
                      ],
                    ),
                    //border: Border.fromBorderSide(BorderSide.none),
                    //shadowStrength: 5,
                    borderRadius: BorderRadius.circular(0),
                    shadowColor: Colors.white.withOpacity(0.24),
                  ),
                ),
              ),
            ),

            // Text(
            //   ' Historia de Cuba',
            //   style: AppTextStyles.titleBold.copyWith(
            //     color: AppColors.white,
            //   ),
            // ),

            //hasScrollBody: false,
            //  fillOverscroll: true,

            (widget.temas.isNotEmpty)
                //  const EdgeInsets.symmetric(
                //       horizontal: 20,
                //       vertical: 15,
                //     ),
                ? SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 20),
                          child: Text(
                            'Temas',
                            style: AppTextStyles.titleBold.copyWith(
                              color: Theme.of(context).primaryIconTheme.color,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: GridView.count(
                            primary: false,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(top: 0),
                            crossAxisCount: 2,
                            //16
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 10,

                            //TODO validaciones like home

                            children: widget.temas
                                .map((tema) => TemaCardWidget(
                                    nombre: tema.descripcion,
                                    cantNiveles: tema.niveles.length,
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.nivelRoute,
                                        arguments: NivelPageArgs(
                                            niveles: tema.niveles,
                                            idAsignatura: widget.idAsignatura,
                                            idEstudiante: widget.idEstudiante,
                                            idTema: tema.id),
                                      );
                                    }))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(I10n.of(context).noData),
            // const SliverFillRemaining(
            //   //hasScrollBody: false,
            //   //  fillOverscroll: true,
            //   child: Center(
            //     child: Text(""),
            //   ),
            // )
          ],
        ));
  }
}
