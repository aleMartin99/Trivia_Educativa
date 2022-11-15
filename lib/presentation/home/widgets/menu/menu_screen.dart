import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../../../../core/core.dart';
import '../../../../data/models/auth_model.dart';
import '../../../../data/models/menu_item.dart';
import '../../../../data/models/models.dart';
import '../../../../main.dart';
import '../../../settings/settings_imports.dart';
import '../../../shared/shared_imports.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'menu_item_widget.dart';
import 'menu_provider.dart';

class MenuScreen extends StatefulWidget {
  final List<MyMenuItem> mainMenu;
  final Function(int) callback;
  final int current;

  const MenuScreen(
    this.mainMenu, {
    super.key,
    // super.key,
    //  required Key key,
    required this.callback,
    required this.current,
  });

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  var auth = sl<Auth>();
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: deviceSize.height,
        ),
        //width: 150,
        decoration: const BoxDecoration(
          gradient: AppGradients.linear,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: SingleChildScrollView(
              child: Column(
                // mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    //height: 652,
                    width: 260,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 24.0, left: 24.0, right: 24.0),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppTheme.backgroundColors(Brightness.dark)
                                    : AppColors.lightPurple
                                //AppColors.lightPurple,

                                ),
                            // color: Colors.blue,
                            width: 75,
                            height: 75,
                            padding: const EdgeInsets.all(5),
                            child: FittedBox(
                              child: Icon(
                                Icons.person,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppColors.lightPurple
                                    : AppColors.grey,
                                //size: 30,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 36.0, left: 24.0, right: 24.0),
                          child: Text(
                            auth.user.name,
                            style: TextStyle(
                              fontSize: 22,
                              color: Theme.of(context).iconTheme.color,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        Selector<MenuProvider, int>(
                          selector: (_, provider) => provider.currentPage,
                          builder: (_, index, __) => Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ...widget.mainMenu
                                  .map((item) => MenuItemWidget(
                                        key: Key(item.index.toString()),
                                        item: item,
                                        callback: widget.callback,
                                        selected: index == item.index,
                                      ))
                                  .toList()
                            ],
                          ),
                        ),
                        // const Spacer(),
                        ValueListenableBuilder(
                          valueListenable: settingsController.themeNotifier,
                          builder: (ctx, value, _) => DedicatedListTile(
                              title: Text(
                                I10n.of(context).darkTheme,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4
                                    ?.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color:
                                            Theme.of(context).iconTheme.color),
                              ),
                              leading: Icon(
                                Icons.dark_mode,
                                color: Theme.of(context).iconTheme.color,
                              ),
                              trailing: Switch.adaptive(
                                  activeColor:
                                      Theme.of(context).iconTheme.color,
                                  value:
                                      EasyDynamicTheme.of(context).themeMode ==
                                          ThemeMode.dark,
                                  onChanged: (v) {
                                    if (v) {
                                      EasyDynamicTheme.of(context).changeTheme(
                                        dark: true,
                                        dynamic: false,
                                      );
                                    } else {
                                      EasyDynamicTheme.of(context).changeTheme(
                                        dynamic: true,
                                        dark: false,
                                      );
                                    }
                                  })),
                        ),
                        // const Spacer(),
                        DedicatedListTile(
                          //TODO I10n
                          onPressed: () async {
                            QuickAlert.show(
                              onConfirmBtnTap: () async {
                                // await sl.resetScope(dispose: false);
                                await sl.popScope();
                                // await sl.unregister<User>();
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/login', (Route<dynamic> route) => false);
                              },
                              context: context,
                              type: QuickAlertType.warning,
                              title: '¿Desea cerrar la sesión?',
                              confirmBtnText: 'Aceptar',
                              cancelBtnText: 'Cancelar',
                              text:
                                  'Tendrá que volver a autenticarse para acceder al sistema',
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              textColor:
                                  Theme.of(context).primaryIconTheme.color!,
                              titleColor:
                                  Theme.of(context).primaryIconTheme.color!,
                              confirmBtnColor: AppColors.purple,
                              showCancelBtn: true,

                              //Colors.transparent
                            );
                          },

                          leading: Icon(Icons.logout,
                              color: Theme.of(context).iconTheme.color),
                          title: Text('Cerrar sesión',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).iconTheme.color
                                      //color: Theme.of(context).primaryColor,
                                      )),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox.expand(),
                  const SizedBox(
                    height: 270,
                  ),
                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      AppInformationWidget(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
