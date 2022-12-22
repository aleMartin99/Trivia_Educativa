import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../../../../core/core.dart';

import '../../../../data/models/auth_model.dart';
import '../../../../data/models/menu_item_model.dart';
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
    SettingsController settingsController =
        Provider.of<SettingsController>(context);
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: height * 100,
        ),
        decoration: const BoxDecoration(
          gradient: AppGradients.linear,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: height * 3.5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: width * 63,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: height * 3,
                              left: width * 5.95,
                              right: width * 5.95),
                          child: CircleAvatar(
                              radius: 45,
                              backgroundColor: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppTheme.backgroundColors(Brightness.dark)
                                  : AppColors.lightPurple,
                              child: SizedBox(
                                  width: width * 18,
                                  height: width * 18,
                                  child: ClipOval(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: width * 1.225,
                                        vertical: height * 0.7,
                                      ),
                                      child: FittedBox(
                                        child: Icon(
                                          Icons.person,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? AppColors.lightPurple
                                              : AppColors.grey,
                                        ),
                                      ),
                                    ),
                                  ))),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: height * 3.7,
                              left: width * 5.7,
                              right: width * 5.7),
                          child: SizedBox(
                            height: height * 6.2,
                            child: Text(
                              auth.user.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 22,
                                color: Theme.of(context).iconTheme.color,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        Selector<MenuProvider, int>(
                          selector: (_, provider) => provider.currentPage,
                          builder: (_, index, __) => Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                        ValueListenableBuilder(
                          valueListenable: settingsController.themeNotifier,
                          builder: (ctx, value, _) => DedicatedListTile(
                              title: Text(
                                I10n.of(context).darkTheme,
                                maxLines: 2,
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
                        DedicatedListTile(
                          onPressed: () async {
                            QuickAlert.show(
                              onConfirmBtnTap: () async {
                                Provider.of<MenuProvider>(context,
                                        listen: false)
                                    .currentPage = 0;
                                await sl.popScope();
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    AppRoutes.loginRoute,
                                    (Route<dynamic> route) => false);
                              },
                              context: context,
                              type: QuickAlertType.warning,
                              title: I10n.of(context).logOutDialogTitle,
                              confirmBtnText: I10n.of(context).ok,
                              cancelBtnText: I10n.of(context).cancel,
                              text: I10n.of(context).logOutDialogBody,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              textColor:
                                  Theme.of(context).primaryIconTheme.color!,
                              titleColor:
                                  Theme.of(context).primaryIconTheme.color!,
                              confirmBtnColor: AppColors.purple,
                              showCancelBtn: true,
                            );
                          },
                          leading: Icon(Icons.logout,
                              color: Theme.of(context).iconTheme.color),
                          title: Text(I10n.of(context).logOutMenuOption,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  ?.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Theme.of(context).iconTheme.color)),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox.expand(),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: height * 31.5, minHeight: height * 29.6),
                  ),
                  Row(
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
