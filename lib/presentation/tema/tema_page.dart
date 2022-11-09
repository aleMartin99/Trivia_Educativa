import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/settings/settings_imports.dart';
import 'tema_imports.dart';
import '../shared/shared_imports.dart';
import '/../core/core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TemaPage extends StatefulWidget {
  const TemaPage({
    Key? key,
    required this.temas,
    required this.idAsignatura,
  }) : super(key: key);
  final List<Tema> temas;
  final String idAsignatura;

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
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.purple,
            expandedHeight: 200,
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
                      Text(
                        I10n.of(context).topics,
                        style: AppTextStyles.titleBold.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // bottom: PreferredSize(
            //   preferredSize: const Size(double.infinity, 65),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
            //                   color: settingsController
            //                       .currentAppTheme.iconTheme.color,
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
            // ),
            //surfaceTintColor: Colors.red,

            pinned: _pinned,
            // snap: _snap,
            floating: _floating,
            flexibleSpace: Container(
              //margin: EdgeInsets.all(0),
              //  height: 2500,
              width: double.maxFinite,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).brightness == Brightness.light
                      ? AppColors.purple
                      : Color.fromARGB(153, 81, 6, 255),
                  const Color(0xFF57B6E0),
                ], stops: const [
                  0.0,
                  1.0
                ], transform: GradientRotation(2.13959913 * pi)),
              ),
              child: FlexibleSpaceBar(
                //title: Text('lalalla'),

                background: Image.asset(
                  'assets/images/temas.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  color: index.isOdd ? Colors.white : Colors.black12,
                  height: 100.0,
                  child: Center(
                    child: Text('$index', textScaleFactor: 1),
                  ),
                );
              },
              childCount: 10,
            ),
          ),
        ],
      ),

      // //TODO make validation for data to all pages like asignatura(home)
      // (widget.temas.isNotEmpty)
      //     ? Padding(
      //         padding: const EdgeInsets.symmetric(
      //           horizontal: 20,
      //           vertical: 15,
      //         ),
      //         child: Padding(
      //           padding: const EdgeInsets.only(top: 24.0),
      //           child: GridView.count(
      //             physics: const BouncingScrollPhysics(),
      //             shrinkWrap: true,
      //             crossAxisCount: 2,
      //             crossAxisSpacing: 16,
      //             mainAxisSpacing: 16,
      //             //*info cambie el ! de temas
      //             //TODO validaciones like home
      //             //TODO ver como controlar q no se parta, poner imagenes de que si no hay elementos...
      //             //TODO Check if next page items is 0 then dialog no items
      //             children: widget.temas
      //                 .map((tema) => TemaCardWidget(
      //                     nombre: tema.descripcion,
      //                     cantNiveles: tema.niveles.length,
      //                     onTap: () {
      //                       //  log('id del tema desde tema page ${tema.id}');
      //                       Navigator.pushNamed(
      //                         context,
      //                         AppRoutes.nivelRoute,
      //                         arguments: NivelPageArgs(
      //                             niveles: tema.niveles,
      //                             idAsignatura: widget.idAsignatura,
      //                             idTema: tema.id),
      //                       );
      //                     }))
      //                 .toList(),
      //           ),
      //         ),
      //       )
      //     : Text(I10n.of(context).noData),
    );
  }
}
