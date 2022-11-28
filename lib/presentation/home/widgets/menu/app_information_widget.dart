import 'dart:io';
import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppInformationWidget extends StatelessWidget {
  const AppInformationWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final _data = snapshot.data;
          final appName = _data?.appName;
          final version = _data?.version;
          final buildNumber = _data?.buildNumber;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '$appName ${Platform.isAndroid ? "Android" : "iOS"} v$version ($buildNumber)',
                //todo textstyle for app information
                style: TextStyle(
                  fontFamily: 'PNRegular',
                  fontSize: 14,
                  color: Theme.of(context).iconTheme.color,
                  fontWeight: FontWeight.w400,
                ),
              ),
              (I10n.of(context).localeName == 'es')
                  ? Text(
                      'Español',
                      //todo textstyle for app information
                      style: TextStyle(
                        fontFamily: 'PNRegular',
                        fontSize: 14,
                        color: Theme.of(context).iconTheme.color,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    )
                  : (I10n.of(context).localeName == 'en')
                      ? Text(
                          'English',
                          //todo textstyle for app information
                          style: TextStyle(
                            fontFamily: 'PNRegular',
                            fontSize: 14,
                            color: Theme.of(context).iconTheme.color,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        )
                      : Text(
                          'Other Language',
                          //todo textstyle for app information
                          style: TextStyle(
                            fontFamily: 'PNRegular',
                            fontSize: 14,
                            color: Theme.of(context).iconTheme.color,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
