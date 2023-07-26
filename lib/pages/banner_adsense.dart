// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yuk_ngaji/utils/const.dart';

class BannerAdsenseScreen extends StatefulWidget {
  const BannerAdsenseScreen({super.key});

  @override
  State<BannerAdsenseScreen> createState() => _BannerAdsenseScreenState();
}

class _BannerAdsenseScreenState extends State<BannerAdsenseScreen> {
  BannerAd? _bannerAd;
  final String _adUnitId = Platform.isAndroid ? banner : banner;

  /// Dimensions of the ad are determined by the AdSize class.
  void _loadAd() async {
    try {
      BannerAd(
        adUnitId: _adUnitId,
        request: const AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            setState(() {
              _bannerAd = ad as BannerAd;
            });
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (ad, err) {
            ad.dispose();
            // print("ad request failed.");
          },
          // Called when an ad opens an overlay that covers the screen.
          onAdOpened: (Ad ad) {
            // print("ad request overlay.");
          },
          // Called when an ad removes an overlay that covers the screen.
          onAdClosed: (Ad ad) {
            // print("ad request removes.");
          },
          // Called when an impression occurs on the ad.
          onAdImpression: (Ad ad) {
            // print("ad request impression.");
          },
        ),
      ).load();
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadAd();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _bannerAd != null
        ? Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: SizedBox(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ),
            ),
          )
        : Container();
  }
}
