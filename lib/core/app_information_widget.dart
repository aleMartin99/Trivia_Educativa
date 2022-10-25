import 'dart:io';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

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
          // final packageName = _data?.packageName;
          final version = _data?.version;
          final buildNumber = _data?.buildNumber;
          return Text(
            //TODO I10n
            '$appName ${Platform.isAndroid ? "Android" : "iOS"} v$version ($buildNumber) \nEspannol',
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
