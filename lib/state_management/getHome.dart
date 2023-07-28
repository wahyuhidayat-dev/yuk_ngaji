// ignore_for_file: file_names, unused_field, avoid_print, unnecessary_null_comparison, library_private_types_in_public_api, no_leading_underscores_for_local_identifiers, unused_local_variable, prefer_final_fields, use_build_context_synchronously

// import 'dart:convert';

// import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:yuk_ngaji/api/apiRepositoy.dart';
// import 'package:yuk_ngaji/model/detaildaftarsurat.dart';
import 'package:yuk_ngaji/pages/detail_surat_screens.dart';
import 'package:yuk_ngaji/pages/detail_tafsir_screens.dart';
import 'package:yuk_ngaji/pages/home_screens.dart';
import 'package:yuk_ngaji/utils/notification_service.dart';
import 'package:yuk_ngaji/utils/utils.dart';
// import 'package:yuk_ngaji/model/detaildaftarsurat.dart';

import '../base/baseController.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

enum StateScreen { initial, loading, loaded, error, empty }

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

class GetXHome extends BaseController {
  RxBool audioplayed = false.obs;
  RxInt indexing = 0.obs;
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

  TextEditingController searchHadistController = TextEditingController();
  TextEditingController searchSuratController = TextEditingController();

  RxList suratFiltered = [].obs;
  RxList items = [].obs;

  // late GlobalKey<ExpansionTileCardState> cardSurat = GlobalKey();
  // final GlobalKey<ExpansionTileCardState> cardHadist = GlobalKey();

//! Setup Notifications
  RxInt id = 0.obs;
  var intValue = Random().nextInt(100);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final StreamController<ReceivedNotification>
      didReceiveLocalNotificationStream =
      StreamController<ReceivedNotification>.broadcast();

  AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/launcher_icon');

  final StreamController<String?> selectNotificationStream =
      StreamController<String?>.broadcast();
  bool _notificationsEnabled = false;

  Future<void> configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  void notificationTapBackground(NotificationResponse notificationResponse) {
    print('notification(${notificationResponse.id}) action tapped: '
        '${notificationResponse.actionId} with'
        ' payload: ${notificationResponse.payload}');
    if (notificationResponse.input?.isNotEmpty ?? false) {
      print(
          'notification action tapped with input: ${notificationResponse.input}');
    }
  }

  Future<void> isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;

      _notificationsEnabled = granted;
    }
  }

  Future<void> requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
          await androidImplementation?.requestPermission();

      _notificationsEnabled = grantedNotificationPermission ?? false;
    }
  }

  void configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: _context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title!)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body!)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.of(context).push(
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => const HomeScreen()),
                );
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  void configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) async {
      await Navigator.of(_context).push(MaterialPageRoute<void>(
        builder: (BuildContext context) => const HomeScreen(),
      ));
    });
  }

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

  Future<bool> checkConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      getAllSurat();
      getHadist();
    } else {
      Utils.showAlert('Check Connection', _context, okFnc: () {
        Get.back();
      });
    }
    return false;
  }

  Future<void> showNotification() async {
    print('disini id nya  ${id.value}');
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        !kIsWeb && Platform.isLinux
            ? null
            : await flutterLocalNotificationsPlugin
                .getNotificationAppLaunchDetails();
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            icon: "@mipmap/launcher_icon",
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
        id.value++, 'time', 'Jangan lupa ngaji', notificationDetails,
        payload: 'item x');
  }

//! Setup time and zone
  tz.TZDateTime _nextInstanceOfSetupTime() {
    tz.initializeTimeZones();
    var locations = tz.timeZoneDatabase.locations;

    var indonesiaTimeZone = tz.getLocation('Asia/Jakarta');

    final tz.TZDateTime now = tz.TZDateTime.now(indonesiaTimeZone);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(indonesiaTimeZone, now.year, now.month, now.day, 17, 45);
    // print(indonesiaTimeZone);
    // print(now);
    // print(scheduledDate);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _nextInstanceOfSetupSubuh() {
    tz.initializeTimeZones();
    var locations = tz.timeZoneDatabase.locations;

    var indonesiaTimeZone = tz.getLocation('Asia/Jakarta');

    final tz.TZDateTime now = tz.TZDateTime.now(indonesiaTimeZone);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(indonesiaTimeZone, now.year, now.month, now.day, 4, 30);
    print(indonesiaTimeZone);
    print(now);
    print(scheduledDate);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

//! fn schedule run notif
  Future<void> scheduleDailyTenAMNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        intValue++,
        '🕠',
        'Jangan lupa ngaji 📖',
        _nextInstanceOfSetupTime(),
        const NotificationDetails(
          android: AndroidNotificationDetails('daily notification channel id',
              'daily notification channel name',
              icon: "@mipmap/launcher_icon",
              importance: Importance.max,
              priority: Priority.high,
              channelDescription: 'daily notification description'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  Future<void> scheduleDailyTenAMNotificationsubuh() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id.value++,
        '🕠',
        'Jangan lupa ngaji 📖',
        _nextInstanceOfSetupSubuh(),
        const NotificationDetails(
          android: AndroidNotificationDetails('daily notification channel id',
              'daily notification channel name',
              channelDescription: 'daily notification description'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  void init(BuildContext context) {
    _context = context;
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    // var initializationSettingsAndroid = AndroidInitializationSettings(
    //     'app_icon'); // <- default icon name is @mipmap/ic_launcher

    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    // flutterLocalNotificationsPlugin.initialize(initializationSettings,
    //     onDidReceiveNotificationResponse: ,
    //     );
    configureLocalTimeZone();
    isAndroidPermissionGranted();
    requestPermissions();
    checkConnection();
    configureDidReceiveLocalNotificationSubject();
    configureSelectNotificationSubject();
    scheduleDailyTenAMNotification();
    // scheduleDailyTenAMNotificationsubuh();
  }

  String removeAllHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    return htmlText.replaceAll(exp, '');
  }

  void filterSearchResults(String query) {
    // getXHome.listDaftarSurat.value =
    items.value = listDaftarSurat
        .where((item) => item['namaLatin']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
  }

//! get all daftar surat
  List listDaftarSurat = [];
  void getAllSurat() async {
    final ApiRepository apiRepository = ApiRepository();
    stateScreen.value = StateScreen.loading;
    isLoading.value = true;
    await apiRepository.getSemuaDaftarSurat().then((value) async {
      if (value.data.isNotEmpty) {
        stateScreen.value = StateScreen.loaded;
        listDaftarSurat = value.data;
        items.value = value.data;
        isLoading.value = false;
        // print('disini ada datanya... ${listDaftarSurat.toString()}');
      } else {
        Get.snackbar(value.code.toString(), value.message);
      }
    }).catchError((onError) {
      stateScreen.value = StateScreen.error;
      isLoading.value = false;
      Utils.handleError(
          context: _context,
          error: onError,
          okFnc: () {
            Get.back();
          });
    });
  }

  //! get all daftar hadist
  RxList listDaftarHadist = [].obs;
  void getHadist() async {
    final ApiRepository apiRepository = ApiRepository();
    stateScreen.value = StateScreen.loading;
    isLoading.value = true;
    await apiRepository.getSemuaDaftarHadist().then((value) async {
      if (value.items.isNotEmpty) {
        stateScreen.value = StateScreen.loaded;
        isLoading.value = false;
        listDaftarHadist.value = value.items;
      } else {
        Get.snackbar('Error', 'No Data');
      }
    }).catchError((onError) {
      stateScreen.value = StateScreen.error;
      isLoading.value = false;
      Utils.handleError(
          context: _context,
          error: onError,
          okFnc: () {
            Get.back();
          });
    });
  }

  void searchHadist(String search) async {
    final ApiRepository apiRepository = ApiRepository();
    stateScreen.value = StateScreen.loading;
    isLoading.value = true;
    listDaftarHadist.clear();
    // String search = searchHadistController.text;
    // print(searchHadistController.text);
    await apiRepository.searchSemuaDaftarHadist(search).then((value) async {
      if (value.items.isNotEmpty) {
        stateScreen.value = StateScreen.loaded;
        isLoading.value = false;
        listDaftarHadist.value = value.items;
      } else {
        Get.snackbar('Error', 'No Data');
      }
    }).catchError((onError) {
      stateScreen.value = StateScreen.error;
      isLoading.value = false;
      Utils.handleError(
          context: _context,
          error: onError,
          okFnc: () {
            Get.back();
          });
    });
  }

  //! get detail surat
  RxMap listDetailSurat = {}.obs;
  void getDetailSurat(String id) async {
    final ApiRepository apiRepository = ApiRepository();
    stateScreen.value = StateScreen.loading;
    isLoading.value = true;
    // print('disini ID nya .. ${id}');
    await apiRepository.getBacaanSurat(id).then((value) async {
      if (value.data.isNotEmpty) {
        stateScreen.value = StateScreen.loaded;
        isLoading.value = false;
        listDetailSurat.value = value.data;
        Get.to(const DetailSuratScreens(
            // listDetailSurat: listDetailSurat,
            ));
      } else {
        Get.snackbar(value.code.toString(), value.message);
      }
    }).catchError((onError) {
      stateScreen.value = StateScreen.error;
      isLoading.value = false;
      Utils.handleError(
          context: _context,
          error: onError,
          okFnc: () {
            Get.back();
          });
    });
  }

  //! get detail tafsir
  Map<String, dynamic> listDetailTafsir = {};
  void getDetaiTafsir(String id) async {
    final ApiRepository apiRepository = ApiRepository();
    stateScreen.value = StateScreen.loading;
    isLoading.value = true;
    await apiRepository.getBacaanTafsir(id).then((value) async {
      if (value.data.isNotEmpty) {
        stateScreen.value = StateScreen.loaded;
        isLoading.value = false;
        listDetailTafsir = value.data;
        // print(listDetailTafsir['tafsir'].toString());
        print('disini ... ${listDetailTafsir['tafsir']}');
        Get.to(DetailTafsirScreens(
          listDetailtafsir: listDetailTafsir,
        ));
      } else {
        Get.snackbar(value.code.toString(), value.message);
      }
    }).catchError((onError) {
      stateScreen.value = StateScreen.error;
      isLoading.value = false;
      Utils.handleError(
          context: _context,
          error: onError,
          okFnc: () {
            Get.back();
          });
    });
  }
}
