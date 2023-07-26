// import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
// ignore_for_file: avoid_print, must_be_immutable

// import 'package:audioplayers/audioplayers.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:page_flip/page_flip.dart';
// import 'package:wave/config.dart';
// import 'package:wave/wave.dart';
import 'package:yuk_ngaji/pages/banner_adsense.dart';
import 'package:yuk_ngaji/state_management/getHome.dart';
// import 'package:yuk_ngaji/state_management/getAudioPlayer.dart';
import 'package:yuk_ngaji/utils/audio_player.dart';
import 'package:yuk_ngaji/utils/const.dart';
import 'package:yuk_ngaji/utils/wave.dart';

class DetailSuratScreens extends StatefulWidget {
  // final Map<String, dynamic> listDetailSurat;
  const DetailSuratScreens({
    super.key,
    // required this.listDetailSurat
  });
// Map<String, dynamic> listDetailSurat = {};
  @override
  State<DetailSuratScreens> createState() => _DetailSuratScreensState();
}

class _DetailSuratScreensState extends State<DetailSuratScreens> {
  InterstitialAd? _interstitialAd;

  final String _adUnitId = Platform.isAndroid ? interstisial : interstisial;

  late GetXHome getXHome;

  @override
  void initState() {
    super.initState();
    getXHome = Get.put(GetXHome());
    _loadAd();
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
            print('InterstitialAd failed to load: $error');
          },
        ));
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List dataAyat = getXHome.listDetailSurat["ayat"];
    // Map<String, dynamic> dataNextAyat =
    //     getXHome.listDetailSurat["suratSelanjutnya"];
    // List chunks = [];
    // int chunkSize = 3;
    // for (var i = 0; i < dataAyat.length; i += chunkSize) {
    //   chunks.add(dataAyat.sublist(i,
    //       i + chunkSize > dataAyat.length ? dataAyat.length : i + chunkSize));
    // }
    // bool updateData = false;

    return SafeArea(
        child: Obx(
      () => Scaffold(
          appBar: AppBar(
              backgroundColor: colorSage,
              elevation: 0,
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      // setState(() {
                      //   updateData != updateData;
                      // });
                      getXHome.getDetailSurat(getXHome
                          .listDetailSurat["suratSelanjutnya"]['nomor']
                          .toString());
                      // dataNextAyat['nomor'],
                      // Get.back();
                      // _interstitialAd?.show().then((value) => Get.back());
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.arrowRight,
                      color: colorDarkBlue,
                    )),
              ],
              leading: IconButton(
                  onPressed: () {
                    if (getXHome.listDetailSurat['nomor'] == 1) {
                      Get.back();
                      // _interstitialAd?.show().then((value) => Get.back());
                    }
                    if (getXHome.listDetailSurat["suratSebelumnya"] == false) {
                      Get.back();
                    } else {
                      getXHome.getDetailSurat(getXHome
                          .listDetailSurat["suratSebelumnya"]['nomor']
                          .toString());
                    }
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: colorDarkBlue,
                  )),
              title: Text(
                getXHome.listDetailSurat["namaLatin"],
                style: fontBold.copyWith(color: colorDarkBlue),
              )),
          backgroundColor: whiteColor,
          body: Stack(children: [
            const BackgroundWave(),
            // RotatedBox(
            //   quarterTurns: 90,
            //   child: SizedBox(
            //     height: double.infinity,
            //     child: WaveWidget(
            //       config: CustomConfig(
            //         colors: const [
            //           Color(0xFFBBDEFB),
            //           Color(0xFF90CAF9),
            //           Color(0xFF64B5F6),
            //           Color(0xFF42A5F5),
            //         ],
            //         durations: [18000, 8000, 5000, 12000],
            //         heightPercentages: [0.01, 0.10, 0.15, 0.25],
            //       ),
            //       backgroundColor: Colors.transparent,
            //       size: const Size(double.infinity, double.infinity),
            //       waveAmplitude: 0,
            //     ),
            //   ),
            // ),
            NewPageScreens(
              data: getXHome.listDetailSurat["ayat"],
              // nextayat: dataNextAyat,
            ),
            const BannerAdsenseScreen()
          ])),
    ));
  }
}

class NewPageScreens extends StatefulWidget {
  NewPageScreens({
    super.key,
    required this.data,
    // required this.nextayat
  });
  List data = [];
  // Map<String, dynamic> nextayat;

  @override
  State<NewPageScreens> createState() => _NewPageScreensState();
}

class _NewPageScreensState extends State<NewPageScreens> {
  bool showPlayer = false;
  bool changeColor = false;
  @override
  Widget build(BuildContext context) {
    // GetXHome getXHome = Get.put(GetXHome());
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.25,
      child: ListView.builder(
        physics: const ScrollPhysics(),
        itemCount: widget.data.length,
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white38),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            // radius: 15,
                            backgroundColor: colorSoftBlue,
                            child: Text(
                              widget.data[index]['nomorAyat'].toString(),
                              style: fontBold.copyWith(
                                  fontSize: 14.sp, color: whiteColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: AudioPlayer(
                              source: widget.data[index]['audio']['05'],
                              onDelete: () {
                                setState(() => showPlayer = false);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            RichText(
                              textAlign: TextAlign.justify,
                              textDirection: TextDirection.rtl,
                              text: TextSpan(
                                  text: '',
                                  style: fontBold.copyWith(
                                      color: grayColor, fontSize: 12.sp),
                                  children: [
                                    TextSpan(
                                      text: widget.data[index]['teksArab'],
                                      style: fontMedium.copyWith(
                                          color: colorDarkBlue,
                                          fontSize: 24.sp),
                                    )
                                  ]),
                            ),

                            Text(
                              widget.data[index]['teksLatin'],
                              textAlign: TextAlign.justify,
                              style: fontMedium.copyWith(
                                  color: colorDarkBlue, fontSize: 14.sp),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.data[index]['teksIndonesia'],
                              textAlign: TextAlign.justify,
                              style: fontBold.copyWith(
                                  color: colorDarkBlue, fontSize: 14.sp),
                            ),
                            // const Padding(
                            //   padding: EdgeInsets.all(8.0),
                            //   child: Divider(
                            //     thickness: 2,
                            //     height: 2,
                            //     color: whiteColor,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class PageScreen extends StatefulWidget {
  const PageScreen(
      {super.key,
      required this.page,
      required this.nomorAyat,
      required this.teksArab,
      required this.teksIndonesia,
      required this.audio,
      required this.totalPage,
      required this.teksLatin});

  final int page, nomorAyat, totalPage;
  final String teksArab, teksLatin, teksIndonesia, audio;

  @override
  State<PageScreen> createState() => _PageScreenState();
}

class _PageScreenState extends State<PageScreen> {
  // late GetXAudioPlayer getXAudioPlayer = Get.put(GetXAudioPlayer());
  // AudioPlayer player = AudioPlayer();
  int maxduration = 100;
  late int currentpos = 0;
  String currentpostlabel = "00:00:00";
  String urlAudio =
      "https://equran.nos.wjv-1.neo.id/audio-partial/Misyari-Rasyid-Al-Afasi/001001.mp3";
  bool isplaying = false;
  bool showPlayer = false;

  late int seekval = 0;

  @override
  void initState() {
    print(widget.audio);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: tileColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      // radius: 15,
                      backgroundColor: pinkColor,
                      child: Text(
                        widget.nomorAyat.toString(),
                        style: fontBold.copyWith(
                            fontSize: 14.sp, color: whiteColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: AudioPlayer(
                        source: widget.audio,
                        onDelete: () {
                          setState(() => showPlayer = false);
                        },
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: RichText(
                    textAlign: TextAlign.justify,
                    textDirection: TextDirection.rtl,
                    text: TextSpan(
                        text: '',
                        style: fontBold.copyWith(
                            color: grayColor, fontSize: 12.sp),
                        children: [
                          TextSpan(
                            text: widget.teksArab,
                            style: fontMedium.copyWith(
                                color: grayColor, fontSize: 24.sp),
                          )
                        ]),
                  ),
                ),
              ],
            ),
            Text(
              widget.teksLatin,
              textAlign: TextAlign.justify,
              style: fontMedium.copyWith(color: grayColor, fontSize: 12.sp),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.teksIndonesia,
              textAlign: TextAlign.justify,
              style: fontMedium.copyWith(color: pinkColor, fontSize: 12.sp),
            ),
            const Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: BannerAdsenseScreen(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
