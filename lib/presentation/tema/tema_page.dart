import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:trivia_educativa/core/routers/routers.dart';
import 'package:trivia_educativa/data/models/models.dart';
import 'package:trivia_educativa/presentation/settings/settings_imports.dart';
import '../../core/theme/text_theme.dart';
import 'tema_imports.dart';
import '/../core/core.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TemaPage extends StatefulWidget {
  const TemaPage(
      {Key? key,
      required this.asignatura,
      required this.idEstudiante,
      required this.notas})
      : super(key: key);
  final Asignatura asignatura;
  final String idEstudiante;
  final List<NotaProv> notas;

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
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              expandedHeight: 220,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                          widget.asignatura.descripcion,
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
                  background: Stack(
                    fit: StackFit.passthrough,
                    children: [
                      const Align(
                        //heightFactor: 1,
                        alignment: Alignment(0.0, -0.6),
                        child: SizedBox(
                          height: 48,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.green,
                              backgroundColor: Colors.black12,
                            ),
                          ),
                        ),
                      ),
                      widget.asignatura.networkImage
                          ? FadeInImage.memoryNetwork(
                              fit: BoxFit.cover,
                              placeholder: kTransparentImage,
                              image: widget.asignatura.image,
                            )
                          : Image.asset(
                              widget.asignatura.image,
                              fit: BoxFit.cover,
                            ),
                    ],
                  ),
                ),
              ),
            ),
            (widget.asignatura.temas.isNotEmpty)
                ? SliverToBoxAdapter(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 20),
                          child: Text(
                            I10n.of(context).topics,
                            style: AppTextStyles.titleBold.copyWith(
                              color: Theme.of(context).primaryIconTheme.color,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: ListView(
                            primary: false,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(top: 0),
                            clipBehavior: Clip.antiAlias,
                            children: widget.asignatura.temas
                                .map((tema) => TemaCardWidget(
                                    nombre: tema.descripcion,
                                    cantNiveles: tema.niveles.length,
                                    onTap: () {
                                      //TODO hacer validacion para tema vacio
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.nivelRoute,
                                        arguments: NivelPageArgs(
                                          niveles: tema.niveles,
                                          tema: tema,
                                          notas: widget.notas,
                                          asignatura: widget.asignatura,
                                          idEstudiante: widget.idEstudiante,
                                        ),
                                      );
                                    }))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(I10n.of(context).noData),
          ],
        ));
  }
}
