import 'package:awesome_drawer_bar/awesome_drawer_bar.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quickalert/quickalert.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import 'package:trivia_educativa/presentation/home/home_controller.dart';
import 'package:trivia_educativa/presentation/scoreboard/scoreboard_card/scoreboard_card.dart';
import 'package:trivia_educativa/presentation/scoreboard/scoreboard_state.dart';
import 'dart:math' show pi;
import '../../core/app_icons.dart';
import '../../core/core.dart';
import '../../core/theme/text_theme.dart';
import '../../data/models/auth_model.dart';
import '../../data/models/estudiante_model.dart';
import '../../main.dart';
import 'scoreboard_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScoreBoardPage extends StatefulWidget {
  const ScoreBoardPage({Key? key}) : super(key: key);

  @override
  State<ScoreBoardPage> createState() => _ScoreBoardPageState();
}

class _ScoreBoardPageState extends State<ScoreBoardPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool get wantKeepAlive => true;

  var auth = sl<Auth>();
  final scoreboardController = ScoreBoardController();
  final homeController = HomeController();
  late Estudiante estudiante;

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _loadDataCurso();
    _loadDataGeneral();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  void _loadDataCurso() async {
    scoreboardController.state = ScoreBoardState.loadingbyAnno;
    await homeController.getEstudiante(auth.user.ci, auth.token);
    estudiante = homeController.estudiante!;
    await scoreboardController.getScorebyAnno(auth.token, estudiante.annoCurso);
    scoreboardController.state == ScoreBoardState.empty;
  }

  void _loadDataGeneral() async {
    await scoreboardController.getScoreGeneral(auth.token);
  }

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    _loadDataCurso();
    _loadDataGeneral();
    scoreboardController.stateNotifier.addListener(() {
      setState(() {});
      if (scoreboardController.state == ScoreBoardState.error) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        QuickAlert.show(
          context: context,
          type: QuickAlertType.error,

          title: I10n.of(context).errorTitle,
          text: I10n.of(context).errorBody,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
          confirmBtnText: I10n.of(context).ok,
          //confirmBtnTextStyle: const TextStyle(color: AppColors.white),
        );
        scoreboardController.state = ScoreBoardState.empty;
      } else if (scoreboardController.state ==
          ScoreBoardState.serverUnreachable) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        QuickAlert.show(
          context: context,
          type: QuickAlertType.loading,
          title: I10n.of(context).serverUnavailableTitle,
          confirmBtnText: I10n.of(context).ok,
          text: I10n.of(context).serverUnavailableBody,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
        );

        scoreboardController.state = ScoreBoardState.empty;
      } else if (scoreboardController.state == ScoreBoardState.notConnected) {
        QuickAlert.show(
          context: context,
          type: QuickAlertType.warning,
          title: I10n.of(context).noInternetConnectionTitle,
          text: I10n.of(context).noInternetConnectionBody,
          confirmBtnText: I10n.of(context).ok,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          textColor: Theme.of(context).primaryIconTheme.color!,
          titleColor: Theme.of(context).primaryIconTheme.color!,
          confirmBtnColor: AppColors.purple,
        );

        scoreboardController.state = ScoreBoardState.empty;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 100;
    double width = MediaQuery.of(context).size.width / 100;
    const angle = 180 * pi / 180;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(height * 20),
            child: SizedBox(
              height: height * 20,
              child: Stack(
                children: [
                  Container(
                      height: height * 20,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 4.5,
                      ),
                      decoration: const BoxDecoration(
                        gradient: AppGradients.linear,
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: EdgeInsets.only(top: height * 7.5),
                            title: Text(
                              I10n.of(context).scoreboardMenuOption,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: AppTextStyles.titleBold,
                            ),
                            leading: Transform.rotate(
                              angle: angle,
                              child: IconButton(
                                icon: Icon(
                                  Icons.menu,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                                onPressed: () {
                                  AwesomeDrawerBar.of(context)?.toggle();
                                },
                              ),
                            ),
                            trailing: CircleAvatar(
                                radius: 30,
                                backgroundColor: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? AppTheme.backgroundColors(
                                        Theme.of(context).brightness)
                                    : AppColors.lightPurple,
                                child: SizedBox(
                                    width: width * 18,
                                    height: width * 18,
                                    child: ClipOval(
                                      child: Padding(
                                        padding: const EdgeInsets.all(9.0),
                                        child: CustomIconSVG(
                                          iconName: AppIcons.trophy,
                                        ),
                                      ),
                                    ))),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: height * 0.9,
                            ),
                            child: TabBar(
                              padding: const EdgeInsets.all(0),
                              splashFactory: NoSplash.splashFactory,
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  return states.contains(MaterialState.focused)
                                      ? null
                                      : Colors.transparent;
                                },
                              ),
                              indicator: MaterialIndicator(
                                height: height / 3.5,
                                horizontalPadding: width * 10,
                                strokeWidth: 3,
                                color: AppColors.lightPurple,
                                tabPosition: TabPosition.bottom,
                              ),
                              automaticIndicatorColorAdjustment: true,
                              controller: _tabController,
                              splashBorderRadius: null,
                              tabs: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(I10n.of(context).myYear,
                                      style:
                                          AppTextStyles.titleBold.copyWith()),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 4.0),
                                  child: Text(I10n.of(context).general,
                                      style: AppTextStyles.titleBold),
                                ),
                              ],
                              indicatorSize: TabBarIndicatorSize.tab,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(
              left: width * 2.25,
              right: width * 2.25,
              top: height * 2.5,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: height * 75,
                  child: SmartRefresher(
                      enablePullUp: false,
                      physics: const BouncingScrollPhysics(),
                      primary: false,
                      header: const MaterialClassicHeader(
                        color: AppColors.purple,
                      ),
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      enablePullDown: true,
                      child: TabBarView(
                          physics: const BouncingScrollPhysics(),
                          controller: _tabController,
                          children: [
                            //*scoreboard anno curso
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 2.25,
                                vertical: height * 1,
                              ),
                              child: (scoreboardController.state ==
                                      ScoreBoardState.loadingbyAnno)
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColors.darkGreen),
                                    ))
                                  : (scoreboardController.scoreboardCurso ==
                                              null ||
                                          scoreboardController
                                              .scoreboardCurso!.isEmpty)
                                      ? Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: width * 4.5,
                                            ),
                                            child: Text(
                                              I10n.of(context)
                                                  .noLocalScoreBoardAvailable,
                                              style: AppTextStyles.titleBold
                                                  .copyWith(
                                                color: Theme.of(context)
                                                    .primaryIconTheme
                                                    .color,
                                              ),
                                            ),
                                          ),
                                        )
                                      : ListView(
                                          shrinkWrap: true,
                                          clipBehavior: Clip.antiAlias,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          children: scoreboardController
                                              .scoreboardCurso!
                                              .map((scoreboardCurso) {
                                            return ScoreBoardCard(
                                              isUser: (scoreboardCurso
                                                          .estudiante.id ==
                                                      estudiante.id)
                                                  ? true
                                                  : false,
                                              name: scoreboardCurso
                                                  .estudiante.name,
                                              promedio:
                                                  scoreboardCurso.promedio,
                                            );
                                          }).toList(),
                                        ),
                            ),

                            //*scoreboard general
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 2.25,
                                vertical: height * 1,
                              ),
                              child: (scoreboardController.state ==
                                      ScoreBoardState.loadingGeneral)
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          AppColors.darkGreen),
                                    ))
                                  : (scoreboardController.scoreboardGeneral ==
                                              null ||
                                          scoreboardController
                                              .scoreboardGeneral!.isEmpty)
                                      ? Center(
                                          child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: width * 4.5,
                                          ),
                                          child: Text(
                                            I10n.of(context)
                                                .noGeneralScoreBoardAvailable,
                                            style: AppTextStyles.titleBold
                                                .copyWith(
                                              color: Theme.of(context)
                                                  .primaryIconTheme
                                                  .color,
                                            ),
                                          ),
                                        ))
                                      : ListView(
                                          shrinkWrap: true,
                                          clipBehavior: Clip.antiAlias,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          children: scoreboardController
                                              .scoreboardGeneral!
                                              .map((scoreboardGeneral) {
                                            return ScoreBoardCard(
                                              isUser: (scoreboardGeneral
                                                          .estudiante.id ==
                                                      estudiante.id)
                                                  ? true
                                                  : false,
                                              name: scoreboardGeneral
                                                  .estudiante.name,
                                              promedio:
                                                  scoreboardGeneral.promedio,
                                            );
                                          }).toList(),
                                        ),
                            ),
                          ])),
                ),
              ],
            ),
          )),
    );
  }
}
