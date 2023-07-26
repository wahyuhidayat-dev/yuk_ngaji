// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, unrelated_type_equality_checks

import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter/services.dart';

class Utils {
  static void handleError(
      {required BuildContext context,
      required dynamic error,
      required VoidCallback okFnc}) {
    if (error is DioException) {
      handleErrorDio(context: context, dioError: error, okFnc: () => okFnc());
    } else {
      showAlert('Unknown', context, okFnc: () => okFnc());
    }
  }

  static void handleErrorDio(
      {required BuildContext context,
      required DioException dioError,
      required VoidCallback okFnc}) {
    switch (dioError.type) {
      case DioExceptionType.badCertificate:
        String text = "Bad Certificate";
        showAlert(text, context, okFnc: okFnc);
        break;
      case DioExceptionType.badResponse:
        String text = "Bad Response";
        showAlert(text, context, okFnc: okFnc);
        break;
      case DioExceptionType.cancel:
        String text = "Request Cancelled";
        showAlert(text, context, okFnc: okFnc);
        break;
      case DioExceptionType.connectionError:
        String text = "Connection Error";
        showAlert(text, context, okFnc: okFnc);
        break;
      case DioExceptionType.connectionTimeout:
        String text = "Connection Timeout";
        showAlert(text, context, okFnc: okFnc);
        break;
      case DioExceptionType.receiveTimeout:
        String text = "Receive Timeout";
        showAlert(text, context, okFnc: okFnc);
        break;
      case DioExceptionType.sendTimeout:
        String text = "Send Timeout";
        showAlert(text, context, okFnc: okFnc);
        break;
      case DioExceptionType.unknown:
      default:
        String text;
        text = "Unknown";
        showAlert(text, context, okFnc: okFnc);
        break;
    }
  }

  static Future<void>? showAlert(String? text, BuildContext context,
      {required VoidCallback okFnc, DialogType type = DialogType.error}) {
    AwesomeDialog(
      context: context,
      dialogType: type,
      headerAnimationLoop: true,
      animType: AnimType.scale,
      showCloseIcon: false,
      desc: text,
      // title: text,
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        okFnc();
      },
    ).show();
    return null;
  }
}
