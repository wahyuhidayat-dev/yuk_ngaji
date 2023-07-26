// ignore_for_file: file_names, avoid_init_to_null

// import 'dart:io';

import 'package:get/get.dart';
import 'package:yuk_ngaji/utils/storageutils.dart';

class GetXSession extends GetxController {
  GetXSession() {
    init();
  }
  RxString? accessToken;
  void accessTokenvoid(String? value) {
    if (value != null) {
      accessToken = value.obs;
      Session.addToString(value, 'accessToken');
    }
  }

  RxString? refreshToken;
  void refreshTokenvoid(String? value) {
    if (value != null) {
      refreshToken = value.obs;
      Session.addToString(value, 'refreshToken');
    }
  }

  RxString? userId = null;
  void userIdvoid(String? value) {
    if (value != null) {
      userId = value.obs;
      Session.addToString(value, 'userId');
    }
  }

  RxString? authCd = null;
  void authCdvoid(String? value) {
    if (value != null) {
      authCd = value.obs;
      Session.addToString(value, 'authCd');
    }
  }

  RxString? userPhone = null;
  void userPhonevoid(String? value) {
    if (value != null) {
      userPhone = value.obs;
      Session.addToString(value, 'userPhone');
    }
  }

  RxString? userNnm = null;
  void userNnmvoid(String? value) {
    if (value != null) {
      userNnm = value.obs;
      Session.addToString(value, 'userNnm');
    }
  }

  RxString? kakaoId = null;
  void kakaoIdvoid(String? value) {
    if (value != null) {
      kakaoId = value.obs;
      Session.addToString(value, 'kakaoId');
    }
  }

  RxString? userYn = null;
  void userYnvoid(String? value) {
    if (value != null) {
      userYn = value.obs;
      Session.addToString(value, 'userYn');
    }
  }

  RxString? birth = null;
  void birthvoid(String? value) {
    if (value != null) {
      birth = value.obs;
      Session.addToString(value, 'birth');
    }
  }

  RxInt? expiredToken = null;
  void expiredTokenvoid(int? value) {
    if (value != null) {
      expiredToken = value.obs;
      Session.addToInt(value, 'expiredToken');
    }
  }
  // RxInt? maxSendCount;
  // void maxSendCountvoid(Int? value) {
  //   if (value != null) {
  //     maxSendCount = value.obs;
  //     Session.addToString(value, 'maxSendCount');
  //   }
  // }

  // RxString? passw = null;
  // void passwvoid(String? value) {
  //   if (value != null) {
  //     passw = value.obs;
  //     Session.addToString(value, 'passw');
  //   }
  // }

  // RxInt? flagHo = null;
  // void flagHovoid(int? value) {
  //   if (value != null) {
  //     flagHo = value.obs;
  //     Session.addToInt(value, "flagHo");
  //   }
  // }

  String? modelDevice;
  String? get getName {
    return modelDevice;
  }

  set setName(String name) {
    modelDevice = name;
  }

//! device info check
  // late AndroidDeviceInfo dataAndroid;
  // RxBool finishDataDeviceInfoLoad = false.obs;
  // RxString currDevice = 'TC'.obs;
  // late BaseDeviceInfo dev;

  // void _getDataAndroid() async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   dev = await deviceInfo.deviceInfo;
  //   currDevice.value = dev.toMap()['model'];
  //   // print(currDevice.value);
  // }

  void init() async {
    // _getDataAndroid();
    accessTokenvoid(await Session.getStringVal('accessToken'));
    refreshTokenvoid(await Session.getStringVal('refreshToken'));
    userIdvoid(await Session.getStringVal('userId'));
    kakaoIdvoid(await Session.getStringVal('kakaoId'));
    authCdvoid(await Session.getStringVal('authCd'));
    userPhonevoid(await Session.getStringVal('userPhone'));
    userNnmvoid(await Session.getStringVal('userNnm'));
    birthvoid(await Session.getStringVal('birth'));
    expiredTokenvoid(await Session.getIntVal('expiredToken'));
    // passwvoid(await Session.getStringVal('passw'));
  }

  void clearSession() {
    Session.clear();
  }
}
