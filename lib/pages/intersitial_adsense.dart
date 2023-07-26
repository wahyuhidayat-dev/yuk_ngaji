import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:yuk_ngaji/utils/const.dart';

class IntersitialScreens extends StatefulWidget {
  const IntersitialScreens({super.key});

  @override
  State<IntersitialScreens> createState() => _IntersitialScreensState();
}

class _IntersitialScreensState extends State<IntersitialScreens> {
  InterstitialAd? _interstitialAd;
  final _gameLength = 2;
  late var _counter = _gameLength;

  final String _adUnitId = Platform.isAndroid ? interstisial : interstisial;

  @override
  void initState() {
    super.initState();

    _startNewGame();
  }

  void _startNewGame() {
    setState(() => _counter = _gameLength);

    _loadAd();
    _starTimer();
  }

  /// Loads an interstitial ad.
  void _loadAd() {
    InterstitialAd.load(
        adUnitId: _adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (InterstitialAd ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
                // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            // ignore: avoid_print
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Game Over'),
              content: Text('You lasted $_gameLength seconds'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _interstitialAd?.show();
                  },
                  child: const Text('OK'),
                )
              ],
            ));
  }

  void _starTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _counter--);

      if (_counter == 0) {
        _showAlert(context);
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Interstitial Example'),
        ),
        body: Stack(
          children: [
            const Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'The Impossible Game',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                )),
            Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${_counter.toString()} seconds left!'),
                    Visibility(
                      visible: _counter == 0,
                      child: TextButton(
                        onPressed: () {
                          _startNewGame();
                        },
                        child: const Text('Play Again'),
                      ),
                    )
                  ],
                )),
          ],
        ));
  }
}
