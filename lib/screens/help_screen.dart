import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:homework_planner/widgets/widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:in_app_review/in_app_review.dart';

import 'package:homework_planner/common/common.dart';
import 'package:homework_planner/helpers/helpers.dart';

@RoutePage()
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('HelpScreen.Title'.tr()),
      ),
      body: FutureBuilder(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) =>
            snapshot.hasData ? _buildBody(context, snapshot.data!) : Container(),
      ),
    );
  }

  Widget _buildBody(BuildContext context, PackageInfo info) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        FormLayout.largeSpacer,
        Image.asset('assets/icons/android.png', width: 64, height: 64),
        FormLayout.textSpacer,
        Text(
          info.appName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        FormLayout.defaultSpacer,
        Text(
          'HelpScreen.VersionText'.tr(args: [
            info.version.toString(),
            info.buildNumber.toString(),
          ]),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        FormLayout.textSpacer,
        const Divider(),
        FormLayout.defaultSpacer,
        ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: Text('HelpScreen.ShareApp'.tr()),
              onTap: () => Share.share(
                Platform.isIOS ? 'HelpScreen.iOSUrl'.tr() : 'HelpScreen.AndroidUrl'.tr(),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: Text('HelpScreen.RateApp'.tr()),
              onTap: () => _rateAppHandler(context),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text('HelpScreen.ContactDev'.tr()),
              onTap: () => launchUrl(Uri.parse(
                'HelpScreen.SupportUrl'.tr(args: [info.appName, info.version]),
              )),
            ),
          ],
        ),
      ],
    );
  }

  void _rateAppHandler(BuildContext context) async {
    try {
      if (Platform.isIOS) {
        await InAppReview.instance.requestReview();
      } else {
        await launchUrl(
          Uri.parse('HelpScreen.AndroidUrl'.tr()),
          mode: LaunchMode.externalNonBrowserApplication,
        );
      }
    } catch (e) {
      showSnackBar(SnackBarStyle.error, 'HelpScreen.RateAppError'.tr());
    }
  }
}
