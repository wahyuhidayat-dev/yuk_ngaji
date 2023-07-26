import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
// import 'package:wave/config.dart';
// import 'package:wave/wave.dart';
import 'package:yuk_ngaji/pages/banner_adsense.dart';
import 'package:yuk_ngaji/utils/const.dart';
import 'package:yuk_ngaji/utils/wave.dart';

class DetailTafsirScreens extends StatefulWidget {
  const DetailTafsirScreens({super.key, required this.listDetailtafsir});
  final Map<String, dynamic> listDetailtafsir;

  @override
  State<DetailTafsirScreens> createState() => _DetailTafsirScreensState();
}

class _DetailTafsirScreensState extends State<DetailTafsirScreens> {
  List dataTafsir = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    dataTafsir = widget.listDetailtafsir['tafsir'];
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: colorDarkBlue),
          backgroundColor: colorSage,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Get.back();
                // _interstitialAd?.show().then((value) => Get.back());
              },
              icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
          title: Text(
            widget.listDetailtafsir["namaLatin"],
            style: fontBold.copyWith(color: colorDarkBlue),
          )),
      body: Stack(
        children: [
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
          const BackgroundWave(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: ListView(
              children: [
                SizedBox(
                  height: 40,
                  width: 100,
                  child: Image.asset(
                    "assets/icons/bismillah_dark.png",
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.4,
                  child: ListView.builder(
                    itemCount: dataTafsir.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white24),
                          child: Text(
                            dataTafsir[index]['teks'],
                            textAlign: TextAlign.justify,
                            style: fontMedium.copyWith(
                                color: colorDarkBlue, fontSize: 16.sp),
                            // widget.listDetailtafsir['tafsir'][index]['teks']
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          const BannerAdsenseScreen()
        ],
      ),
    );
  }
}
