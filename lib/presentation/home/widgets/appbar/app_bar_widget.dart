import 'package:educational_quiz_app/core/app_routes.dart';
import 'package:educational_quiz_app/core/core.dart';
import 'package:educational_quiz_app/data/models/nota_prov_model.dart';
import 'package:educational_quiz_app/data/models/user_model.dart';
import 'package:educational_quiz_app/core/routers/routers.dart';
import 'package:educational_quiz_app/presentation/home/widgets/score_card/score_card_widget.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends PreferredSize {
  final User user;
  final List<NotaProv> notasProv;
  final BuildContext context;

  static int cantAprobados(List<NotaProv> notasProv) {
    int cantAprobados = 0;
    for (int i = 0; i < notasProv.length; i++) {
      if (notasProv[i].nota > 2) cantAprobados++;
    }
    return cantAprobados;
  }

  // static aprobados = cantAprobados(notasProv);

  AppBarWidget(
      {Key? key,
      required this.user,
      required this.notasProv,
      required this.context})
      : super(
          key: key,
          preferredSize: const Size.fromHeight(250),
          child: SizedBox(
            height: 270,
            child: Stack(
              children: [
                Container(
                    height: 161,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    decoration: const BoxDecoration(
                      gradient: AppGradients.linear,
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(top: 60),
                      title: Text.rich(
                        TextSpan(
                          text: "Hola, ",
                          style: AppTextStyles.title,
                          children: [
                            TextSpan(
                              text: user.nombreUsuario,
                              style: AppTextStyles.titleBold,
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.settingsRoute,
                            arguments: SettingsPageArgs(user: user),
                          );
                        },
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          // color: Colors.blue,
                          width: 75,
                          height: 75,

                          //*Carga Bien la imagen de BD, se modifico manualmente el nombre de la imagen en
                          //* la direccion(local host por la direccion del emulador) por problemas
                          child: Image.network(
                            user.imagen!,
                          ),
                        ),
                      ),
                    )),
                Align(
                  alignment: const Alignment(0.0, 1.0),
                  child: ScoreCardWidget(
                    scorePercentage: (notasProv.isNotEmpty)
                        ? (cantAprobados(notasProv) / notasProv.length)
                            .toDouble()
                        : 0,
                  ),
                ),
              ],
            ),
          ),
        );
}
