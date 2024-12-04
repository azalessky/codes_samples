import 'dart:async';

import 'package:flutter/material.dart';
import 'package:homework_planner/helpers/helpers.dart';
import 'package:yandex_mobileads/mobile_ads.dart';

import 'package:homework_planner/common/common.dart';

class AdBanner extends StatefulWidget {
  final String unitId;
  final double maxHeight;
  final EdgeInsets padding;
  final Function() onAdLoaded;
  final Function() onAdFailed;

  const AdBanner({
    required this.unitId,
    required this.maxHeight,
    required this.padding,
    required this.onAdLoaded,
    required this.onAdFailed,
    super.key,
  });

  @override
  State<AdBanner> createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  final counter = ValueNotifier(0);
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(AdSettings.rotationDuration, (_) => counter.value++);
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: widget.padding,
          child: ValueListenableBuilder(
            valueListenable: counter,
            builder: (context, _, __) => AdWidget(
              key: ValueKey(counter.value),
              bannerAd: _buildBanner(context),
            ),
          ),
        ),
      ),
    );
  }

  BannerAd _buildBanner(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width.round();
    final adSize = BannerAdSize.inline(width: screenWidth, maxHeight: widget.maxHeight.toInt());

    return BannerAd(
      adUnitId: widget.unitId,
      adSize: adSize,
      adRequest: const AdRequest(),
      onAdLoaded: () {
        widget.onAdLoaded();
        logEvent(AnalyticsEvent.adLoaded);
      },
      onAdFailedToLoad: (_) {
        widget.onAdFailed();
        logEvent(AnalyticsEvent.adFailed);
      },
      onAdClicked: () => logEvent(AnalyticsEvent.adClicked),
      onImpression: (_) => logEvent(AnalyticsEvent.adImpression),
    );
  }
}
