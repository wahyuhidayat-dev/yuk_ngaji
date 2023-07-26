// ignore_for_file: file_names, unused_field, avoid_print, unnecessary_null_comparison, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_final_fields

// import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yuk_ngaji/api/apiRepositoy.dart';
// import 'package:yuk_ngaji/model/detaildaftarsurat.dart';

import '../base/baseController.dart';

enum StateScreen { initial, loading, loaded, error, empty }

class GetXHadist extends BaseController {
  RxDouble currentIndex = 0.0.obs;
  var pageController = PageController().obs;
  RxBool enabledDate = true.obs;

  late BuildContext _context;
  RxBool finishPackageInfoLoad = false.obs;
  RxString dateString = "Barcode will be shown here".obs;
  Rx<StateScreen> stateScreen = StateScreen.initial.obs;
  bool? _popupBuilderSelection = false;

  RxBool isLoading = false.obs;

  DateTime today = DateTime.now();
  DateTime? currentBackPressTime = DateTime.now();
  RxInt pageIndex = 0.obs;

  DateFormat format = DateFormat("EEEE, d MMMM yyyy");

  RxBool finishDataDeviceInfoLoad = false.obs;
  late List<Map<String, String>> choice;
  late Map<String, String> selectedChoice;
  RxString choiceSelected = " ".obs;
  void setSelected(String value) {
    choiceSelected.value = value;
  }

  Future<bool> onWillPop() {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
      return Future.value(false);
    }
    if (pageController.value.page != 0) {
      pageController.value.jumpToPage(0);

      currentIndex.value = pageController.value.page!;
      return Future.value(false);
    } else {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 3)) {
        currentBackPressTime = now;

        Get.showSnackbar(const GetSnackBar(
          title: "Press again in 3 second to exit",
        ));

        return Future.value(false);
      }
      return Future.value(true);
    }
  }

  void init(BuildContext context) {
    _context = context;
    getHadist();
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

//! get all daftar surat
  List listDaftarHadist = [];
  void getHadist() async {
    final ApiRepository apiRepository = ApiRepository();
    stateScreen.value = StateScreen.loading;
    isLoading.value = true;
    await apiRepository.getSemuaDaftarHadist().then((value) async {
      if (value.items.isNotEmpty) {
        stateScreen.value = StateScreen.loaded;
        isLoading.value = false;
        listDaftarHadist = value.items;
      }
    });
  }
}
