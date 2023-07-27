// ignore_for_file: sort_child_properties_last, avoid_print

import 'dart:io';

import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:loading_animations/loading_animations.dart';
// import 'package:wave/config.dart';
// import 'package:wave/wave.dart';
import 'package:yuk_ngaji/pages/banner_adsense.dart';
import 'package:yuk_ngaji/pages/detail_hadist_screens.dart';
import 'package:yuk_ngaji/pages/intersitial_adsense.dart';
// import 'package:yuk_ngaji/pages/list_surat_screens.dart';
import 'package:yuk_ngaji/state_management/getHome.dart';
import 'package:yuk_ngaji/utils/const.dart';
import 'package:yuk_ngaji/utils/customNavigationBar.dart';
import 'package:yuk_ngaji/utils/wave.dart';

// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GetXHome getXHome;

  @override
  void initState() {
    getXHome = Get.put(GetXHome());
    super.initState();
    getXHome.init(context);
  }

  @override
  void dispose() {
    getXHome.didReceiveLocalNotificationStream.close();
    getXHome.selectNotificationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: getXHome.onWillPop,
      child: SafeArea(
          child: Scaffold(
        body: PageView(
          controller: getXHome.pageController.value,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (i) {
            getXHome.pageIndex.value = i;
          },
          children: const [
            DaftarSuratScreens(),
            DaftarHadistScreens(),
            SettingsScreens()
          ],
        ),
        bottomNavigationBar: Obx(
          () => CustomBottomNavigation(
              itemCornerRadius: 30,
              selectedIndex: getXHome.currentIndex.value.toInt(),
              animationDuration: const Duration(milliseconds: 350),
              selectedItemOverlayColor: Colors.white.withAlpha(48),
              backgroundColor: colorSoftBlue,
              textStyle: fontBold.copyWith(fontSize: 18.sp),
              onItemSelected: (index) {
                getXHome.currentIndex.value = index.roundToDouble();
                getXHome.pageController.value.jumpToPage(index);
              },
              items: <CustomBottomNavigationBarItem>[
                CustomBottomNavigationBarItem(
                    icon: const FaIcon(
                      FontAwesomeIcons.bookOpen,
                    ),
                    title: 'Surat',
                    textStyle: fontMedium.copyWith(fontSize: 16.sp),
                    activeColor: whiteColor,
                    inactiveColor: colorOceanBlue),
                CustomBottomNavigationBarItem(
                    icon: const FaIcon(
                      FontAwesomeIcons.bookBookmark,
                    ),
                    title: 'Hadist',
                    textStyle: fontMedium.copyWith(fontSize: 16.sp),
                    activeColor: whiteColor,
                    inactiveColor: colorOceanBlue),
                CustomBottomNavigationBarItem(
                    icon: const FaIcon(
                      FontAwesomeIcons.star,
                    ),
                    title: 'FAQ',
                    textStyle: fontMedium.copyWith(fontSize: 16.sp),
                    activeColor: whiteColor,
                    inactiveColor: colorOceanBlue),
              ]),
        ),
      )),
    );
  }
}

class DaftarSuratScreens extends StatefulWidget {
  const DaftarSuratScreens({super.key});

  @override
  State<DaftarSuratScreens> createState() => _DaftarSuratScreensState();
}

class _DaftarSuratScreensState extends State<DaftarSuratScreens> {
  late GetXHome getXHome;
  TextEditingController searchSuratController = TextEditingController();

  @override
  void initState() {
    getXHome = Get.put(GetXHome());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(getXHome.items.value.toString());
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const BackgroundWave(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white12),
              child: ListView(
                children: [
                  // FloatingActionButton(onPressed: () async {
                  //   await getXHome.showNotification();
                  // }),
                  // Container(
                  //   width: ScreenUtil().scaleWidth,
                  //   height: 150,
                  //   decoration: BoxDecoration(
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: grayColor.withOpacity(0.5),
                  //           spreadRadius: 0,
                  //           blurRadius: 5,
                  //           offset:
                  //               const Offset(0, 3), // changes position of shadow
                  //         ),
                  //       ],
                  //       borderRadius: const BorderRadius.only(
                  //           bottomLeft: Radius.circular(12),
                  //           bottomRight: Radius.circular(12)),
                  //       color: blueColor),
                  //   child: Column(
                  //     // mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Row(
                  //         mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //         children: [
                  //           SizedBox(
                  //             width: 250.w,
                  //             height: 100.w,
                  //             child: Image.asset(
                  //               "assets/images/assalamualaikum.png",
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             width: 100.w,
                  //             height: 100.w,
                  //             child: Image.asset(
                  //               "assets/icons/quran.png",
                  //               fit: BoxFit.cover,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //       Text(
                  //         getXHome.format.format(getXHome.today),
                  //         style:
                  //             fontBold.copyWith(color: grayColor, fontSize: 12.sp),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 250.w,
                  //   height: 100.w,
                  //   child: Image.asset(
                  //     "assets/images/assalamualaikum.png",
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  // ! Search Field
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 12, vertical: 12),
                  //   child: TextField(
                  //     controller: searchSuratController,
                  //     style: fontMedium.copyWith(
                  //         color: whiteColor, fontSize: 14.sp),
                  //     onChanged: (value) {
                  //       getXHome.filterSearchResults(value);
                  //     },
                  //     decoration: InputDecoration(
                  //       fillColor: whiteColor,
                  //       enabledBorder: const OutlineInputBorder(
                  //           borderSide:
                  //               BorderSide(width: 1, color: Colors.white24)),
                  //       hintText: "Search Surat",
                  //       hintStyle: fontLight.copyWith(color: whiteColor),
                  //       contentPadding: const EdgeInsets.all(12),
                  //       suffixIcon: IconButton(
                  //           onPressed: () {
                  //             Get.to(const IntersitialScreens());
                  //           },
                  //           icon: const Icon(
                  //             size: 30,
                  //             Icons.search,
                  //             color: whiteColor,
                  //           )),
                  //       border: const UnderlineInputBorder(
                  //           borderSide:
                  //               BorderSide(width: 1, color: Colors.white)),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: Image.asset(
                      "assets/icons/bismillah_dark.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextFormField(
                      style: fontLight.copyWith(color: colorDarkBlue),
                      controller: searchSuratController,
                      onChanged: (value) {
                        getXHome.filterSearchResults(value);
                      },
                      decoration: InputDecoration(
                        hintText: "Search Surat",
                        // labelText: "Search",
                        // labelStyle: fontLight.copyWith(color: whiteColor),
                        hintStyle: fontLight.copyWith(color: colorDarkBlue),
                        suffixIcon: IconButton(
                            onPressed: () {
                              Get.to(const IntersitialScreens());
                            },
                            icon: const Icon(
                              size: 30,
                              Icons.search,
                              color: colorDarkBlue,
                            )),
                        fillColor: colorDarkBlue,
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: colorDarkBlue, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0)),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: colorDarkBlue, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0)),
                        disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: colorDarkBlue, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: colorDarkBlue, width: 2.0),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Obx(() => getXHome.isLoading.value
                      ? Center(
                          child: LoadingBouncingGrid.square(
                            backgroundColor: whiteColor,
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height / 1.5,
                          child: ListView.builder(
                            itemCount: getXHome.items.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ExpansionTileCard(
                                    baseColor: Colors.white24,
                                    expandedColor: Colors.white38,
                                    elevation: 0,
                                    colorCurve: Curves.bounceInOut,
                                    leading: CircleAvatar(
                                      backgroundColor: colorSoftBlue,
                                      child: Text(
                                        getXHome.items[index]['nomor']
                                            .toString(),
                                        style: fontBold.copyWith(
                                            fontSize: 14.sp, color: whiteColor),
                                      ),
                                    ),
                                    title: Text(
                                      getXHome.items[index]['nama'] ?? '',
                                      style: fontBold.copyWith(
                                          fontSize: 14.sp,
                                          color: colorDarkBlue),
                                    ),
                                    subtitle: Text(
                                      getXHome.items[index]['namaLatin'] ?? '',
                                      style: fontBold.copyWith(
                                          fontSize: 14.sp,
                                          color: colorDarkBlue),
                                    ),
                                    children: [
                                      const Divider(
                                        height: 2,
                                        thickness: 2,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${getXHome.items[index]['arti'] ?? ''} - ${getXHome.items[index]['tempatTurun'] ?? ''}',
                                          style: fontBold.copyWith(
                                              fontSize: 14.sp,
                                              color: colorDarkBlue),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          getXHome.removeAllHtmlTags(getXHome
                                                  .items[index]['deskripsi'] ??
                                              ''),
                                          textAlign: TextAlign.justify,
                                          style: fontMedium.copyWith(
                                              fontSize: 14.sp,
                                              color: colorDarkBlue),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      colorSoftBlue),
                                              onPressed: () {
                                                print(getXHome
                                                    .listDaftarSurat[index]
                                                        ['nomor']
                                                    .toString());
                                                getXHome.getDetailSurat(getXHome
                                                    .listDaftarSurat[index]
                                                        ['nomor']
                                                    .toString());
                                              },
                                              child: Text(
                                                'Baca Surat',
                                                style: fontMedium.copyWith(
                                                    fontSize: 14.sp,
                                                    color: whiteColor),
                                              )),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor:
                                                      colorSoftBlue),
                                              onPressed: () {
                                                getXHome.getDetaiTafsir(getXHome
                                                    .listDaftarSurat[index]
                                                        ['nomor']
                                                    .toString());
                                              },
                                              child: Text(
                                                'Baca Tafsir',
                                                style: fontMedium.copyWith(
                                                    fontSize: 14.sp,
                                                    color: whiteColor),
                                              )),
                                        ],
                                      )
                                    ],
                                  ));
                            },
                          ),
                        )),
                ],
              ),
            ),
          ),
          const BannerAdsenseScreen(),
        ],
      ),
    );
  }
}

class DaftarHadistScreens extends StatelessWidget {
  const DaftarHadistScreens({super.key});

  @override
  Widget build(BuildContext context) {
    GetXHome getXHome = Get.put(GetXHome());
    // getXHadist.init(context);
    return Stack(
      children: [
        const BackgroundWave(),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white12),
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
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    style: fontLight.copyWith(color: colorDarkBlue),
                    controller: getXHome.searchHadistController,
                    onChanged: (value) {
                      getXHome
                          .searchHadist(getXHome.searchHadistController.text);
                    },
                    decoration: InputDecoration(
                      hintText: "Search Terjemahan",
                      // labelText: "Search",
                      // labelStyle: fontLight.copyWith(color: whiteColor),
                      hintStyle: fontLight.copyWith(color: colorDarkBlue),
                      suffixIcon: IconButton(
                          onPressed: () {
                            // Get.to(const IntersitialScreens());
                          },
                          icon: const Icon(
                            size: 30,
                            Icons.search,
                            color: colorDarkBlue,
                          )),
                      fillColor: colorDarkBlue,
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: colorDarkBlue, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0)),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: colorDarkBlue, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: colorDarkBlue, width: 1.0),
                          borderRadius: BorderRadius.circular(10.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: colorDarkBlue, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Obx(() => getXHome.isLoading.value
                    ? Align(
                        alignment: Alignment.center,
                        child: LoadingBouncingGrid.square(
                          backgroundColor: whiteColor,
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height / 1.5,
                        child: ListView.builder(
                          itemCount: getXHome.listDaftarHadist.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ExpansionTileCard(
                                  baseColor: Colors.white24,
                                  contentPadding: const EdgeInsets.all(2),
                                  expandedColor: Colors.white38,
                                  elevation: 0,
                                  colorCurve: Curves.bounceInOut,
                                  leading: CircleAvatar(
                                    backgroundColor: colorSoftBlue,
                                    child: Text(
                                      getXHome.listDaftarHadist[index]['nomor']
                                          .toString(),
                                      style: fontBold.copyWith(
                                          fontSize: 14.sp, color: whiteColor),
                                    ),
                                  ),
                                  title: Text(
                                    getXHome.listDaftarHadist[index]['riwayat'],
                                    style: fontBold.copyWith(
                                        fontSize: 14.sp, color: colorDarkBlue),
                                  ),
                                  subtitle: Text(
                                    getXHome.listDaftarHadist[index]
                                        ['terjemahan'],
                                    textAlign: TextAlign.justify,
                                    maxLines: 4,
                                    style: fontLight.copyWith(
                                        fontSize: 14.sp, color: colorDarkBlue),
                                  ),
                                  children: [
                                    const Divider(
                                      height: 2,
                                      thickness: 2,
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Text(
                                    //     getXHome.listDaftarHadist[index]['arabic'],
                                    //     textAlign: TextAlign.justify,
                                    //     textDirection: TextDirection.rtl,
                                    //     style: fontMedium.copyWith(
                                    //         fontSize: 14.sp, color: grayColor),
                                    //   ),
                                    // ),
                                    // Padding(
                                    //   padding: const EdgeInsets.all(8.0),
                                    //   child: Text(
                                    //     getXHome.listDaftarHadist[index]
                                    //         ['terjemahan'],
                                    //     textAlign: TextAlign.justify,
                                    //     style: fontMedium.copyWith(
                                    //         fontSize: 14.sp, color: grayColor),
                                    //   ),
                                    // ),
                                    TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: colorSoftBlue),
                                        onPressed: () {
                                          Get.to(DetailHadistScreens(
                                              nomor: getXHome
                                                      .listDaftarHadist[index]
                                                  ['nomor'],
                                              riwayat: getXHome
                                                      .listDaftarHadist[index]
                                                  ['riwayat'],
                                              perawi: getXHome
                                                      .listDaftarHadist[index]
                                                  ['perawi'],
                                              arabic: getXHome
                                                      .listDaftarHadist[index]
                                                  ['arabic'],
                                              terjemahan: getXHome
                                                      .listDaftarHadist[index]
                                                  ['terjemahan']));
                                        },
                                        child: Text(
                                          'Baca Hadist',
                                          style: fontMedium.copyWith(
                                              fontSize: 14.sp,
                                              color: whiteColor),
                                        ))
                                  ],
                                ));
                          },
                        ),
                      ))
              ],
            ),
          ),
        ),
        const BannerAdsenseScreen(),
      ],
    );
  }
}

class SettingsScreens extends StatefulWidget {
  const SettingsScreens({super.key});

  @override
  State<SettingsScreens> createState() => _SettingsScreensState();
}

class _SettingsScreensState extends State<SettingsScreens> {
  @override
  Widget build(BuildContext context) {
    GetXHome getXHome = Get.put(GetXHome());
    return Scaffold(
        body: Stack(
      children: [
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

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 40,
                width: 100,
                child: Image.asset(
                  "assets/icons/bismillah_dark.png",
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: ListView.builder(
                  itemCount: dataFaq['faq'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExpansionTileCard(
                          baseColor: Colors.white24,
                          expandedColor: Colors.white38,
                          elevation: 0,
                          colorCurve: Curves.bounceInOut,
                          leading: CircleAvatar(
                            backgroundColor: colorSoftBlue,
                            child: Text(
                              dataFaq['faq'][index]['id'],
                              style: fontBold.copyWith(
                                  fontSize: 14.sp, color: whiteColor),
                            ),
                          ),
                          title: Text(
                            dataFaq['faq'][index]['pertanyaan'] ?? '',
                            style: fontBold.copyWith(
                                fontSize: 14.sp, color: colorDarkBlue),
                          ),
                          subtitle: Text(
                            '',
                            style: fontBold.copyWith(
                                fontSize: 14.sp, color: colorDarkBlue),
                          ),
                          children: [
                            const Divider(
                              color: Colors.white24,
                              height: 2,
                              thickness: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                getXHome.removeAllHtmlTags(
                                    dataFaq['faq'][index]['jawaban'] ?? ''),
                                textAlign: TextAlign.justify,
                                style: fontMedium.copyWith(
                                    fontSize: 14.sp, color: colorDarkBlue),
                              ),
                            ),
                          ],
                        ));
                  },
                ),
              ),
            ],
          ),
        )
        // Padding(
        //     padding: const EdgeInsets.all(12.0),
        //     child: Container(
        //       padding: const EdgeInsets.all(10),
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(10),
        //           color: Colors.white12),
        //       child: ListView(children: [
        //         SizedBox(
        //           height: 50,
        //           child: Image.asset(
        //             "assets/icons/bismillah_white.png",
        //             fit: BoxFit.contain,
        //           ),
        //         ),
        //         const SizedBox(
        //           height: 20,
        //         ),
        //         Container(
        //           height: 60,
        //           width: MediaQuery.of(context).size.width,
        //           decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(10),
        //               color: Colors.white24),
        //         )
        //       ]),
        //     )),
      ],
    ));
  }
}
