import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:wave/config.dart';
// import 'package:wave/wave.dart';
import 'package:yuk_ngaji/pages/banner_adsense.dart';
import 'package:yuk_ngaji/utils/const.dart';
import 'package:yuk_ngaji/utils/wave.dart';

class DetailHadistScreens extends StatefulWidget {
  const DetailHadistScreens(
      {super.key,
      required this.nomor,
      required this.riwayat,
      required this.perawi,
      required this.arabic,
      required this.terjemahan});

  final int nomor;
  final String riwayat, perawi, arabic, terjemahan;

  @override
  State<DetailHadistScreens> createState() => _DetailHadistScreensState();
}

class _DetailHadistScreensState extends State<DetailHadistScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: colorDarkBlue),
        elevation: 0,
        centerTitle: true,
        backgroundColor: colorSage,
        title: Text(
          widget.riwayat,
          textAlign: TextAlign.center,
          style: fontBold.copyWith(color: colorDarkBlue, fontSize: 16.sp),
        ),
      ),
      backgroundColor: tileColor,
      body: Stack(children: [
        const BackgroundWave(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height / 1.25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white24),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.justify,
                            textDirection: TextDirection.rtl,
                            text: TextSpan(text: '', children: [
                              TextSpan(
                                text: widget.arabic,
                                style: fontBold.copyWith(
                                    color: colorDarkBlue, fontSize: 20.sp),
                              )
                            ]),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        widget.riwayat,
                        textAlign: TextAlign.justify,
                        style: fontBold.copyWith(
                            color: colorDarkBlue, fontSize: 16.sp),
                      ),
                    ),
                    Text(
                      widget.terjemahan,
                      textAlign: TextAlign.justify,
                      style: fontMedium.copyWith(
                          color: colorDarkBlue, fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const BannerAdsenseScreen()
      ]),
    );
  }
}
