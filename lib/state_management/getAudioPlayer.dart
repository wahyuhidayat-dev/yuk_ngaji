// ignore_for_file: file_names, unused_field, avoid_print, unnecessary_null_comparison, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_final_fields

// import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:yuk_ngaji/api/apiRepositoy.dart';
// import 'package:yuk_ngaji/model/detaildaftarsurat.dart';

import '../base/baseController.dart';

enum StateScreen { initial, loading, loaded, error, empty }

class GetXAudioPlayer extends BaseController {
  // RxDouble currentIndex = 0.0.obs;
  // var pageController = PageController().obs;
  // RxBool enabledDate = true.obs;

  late BuildContext _context;
  RxBool finishPackageInfoLoad = false.obs;
  Rx<StateScreen> stateScreen = StateScreen.initial.obs;
  bool? _popupBuilderSelection = false;

  RxBool isLoading = false.obs;

  DateTime today = DateTime.now();
  DateTime? currentBackPressTime = DateTime.now();
  // RxInt pageIndex = 0.obs;

  // DateFormat format = DateFormat("EEEE, d MMMM yyyy");

  // RxBool finishDataDeviceInfoLoad = false.obs;
  // late List<Map<String, String>> choice;
  // late Map<String, String> selectedChoice;
  // RxString choiceSelected = " ".obs;
  // void setSelected(String value) {
  //   choiceSelected.value = value;
  // }

  RxInt maxduration = 100.obs;
  RxInt currentpos = 0.obs;
  RxString currentpostlabel = "00:00".obs;
  // String audioasset = "assets/audio/red-indian-music.mp3";
  RxBool isplaying = false.obs;
  RxBool audioplayed = false.obs;
  // late Uint8List audiobytes;

  void init(BuildContext context) {
    _context = context;
  }

  // RxString urlStream =
  //     "https://equran.nos.wjv-1.neo.id/audio-partial/Misyari-Rasyid-Al-Afasi/001001.mp3"
  //         .obs;
  AudioPlayer player = AudioPlayer();
  void soundSurat(String url) async {
    await player.play(UrlSource(url));

    Future.delayed(Duration.zero, () async {
      player.onDurationChanged.listen((Duration d) {
        //get the duration of audio
        maxduration.value = d.inMilliseconds;
      });

      player.onPositionChanged.listen((Duration p) {
        currentpos.value =
            p.inMilliseconds; //get the current position of playing audio

        //generating the duration label
        int shours = Duration(milliseconds: currentpos.value).inHours;
        int sminutes = Duration(milliseconds: currentpos.value).inMinutes;
        int sseconds = Duration(milliseconds: currentpos.value).inSeconds;

        int rhours = shours;
        int rminutes = sminutes - (shours * 60);
        int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);

        currentpostlabel.value = "$rhours:$rminutes:$rseconds";
      });
    });
  }
}
