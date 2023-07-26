// ignore_for_file: unused_import, file_names, use_rethrow_when_possible, avoid_print, deprecated_member_use

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as http_dio;
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuk_ngaji/api/apiInterceptor.dart';
import 'package:yuk_ngaji/model/daftarhadist.dart';
import 'package:yuk_ngaji/model/daftarsurat.dart';
import 'package:yuk_ngaji/model/detailsurat.dart';
import 'package:yuk_ngaji/model/detailtafsir.dart';
import 'package:yuk_ngaji/pages/home_screens.dart';
import 'package:yuk_ngaji/utils/const.dart';

class ApiProvider {
  late http_dio.Response response;
  http_dio.Dio dio = http_dio.Dio();
  ApiProvider() {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    // dio.options.headers = {"Content-Type": "application/x-www-form-urlencoded"};
    // dio.options.contentType = 'application/x-www-form-urlencoded';
    // dio.options.headers = {"Content-Type": "application/json"};
    dio.options.connectTimeout = Duration(milliseconds: timeout);
    dio.options.receiveTimeout = Duration(milliseconds: timeout);
    dio.interceptors.add(DioLoggingInterceptors(dio));
    dio.interceptors.add(http_dio.LogInterceptor(responseBody: true));
  }

  Future<DaftarSurat> getDaftarSurat() async {
    late DaftarSurat daftarSurat;
    try {
      response = await dio.get(apiURL + endpointdaftarSurat);
      if (response.statusCode == 200) {
        daftarSurat = DaftarSurat.fromJson(response.data);
        // print("disiniiii");
        // print(response.data.toString());
      }
      dio.close();
      return daftarSurat;
    } on http_dio.DioError catch (e) {
      throw (e);
    }
  }

  Future<DetailSurat> getDetailSurat(String id) async {
    // print('disiniiiii ${id}');
    late DetailSurat daftarSurat;
    try {
      response = await dio.get(apiURL + endpointdetailSurat + id);
      if (response.statusCode == 200) {
        daftarSurat = DetailSurat.fromJson(response.data);
        // print("disiniiii");
        // print(response.data.toString());
      }
      dio.close();
      return daftarSurat;
    } on http_dio.DioError catch (e) {
      throw (e);
    }
  }

  Future<DetailTafsir> getDetailTafsir(String id) async {
    late DetailTafsir daftarTafsir;
    try {
      response = await dio.get(apiURL + endpointdetailTafsir + id);
      if (response.statusCode == 200) {
        daftarTafsir = DetailTafsir.fromJson(response.data);
        // print("disiniiii");
        // print(response.data.toString());
      }
      dio.close();
      return daftarTafsir;
    } on http_dio.DioError catch (e) {
      throw (e);
    }
  }

  Future<DaftarHadist> getDaftarHadist() async {
    late DaftarHadist daftarSurat;
    try {
      response = await dio.get(apiHadistURL + searchHadist);
      if (response.statusCode == 200) {
        daftarSurat = DaftarHadist.fromJson(response.data);
      }
      dio.close();
      return daftarSurat;
    } on http_dio.DioError catch (e) {
      throw (e);
    }
  }

  Future<DaftarHadist> searchDaftarHadist(String query) async {
    late DaftarHadist daftarSurat;
    print(query);
    try {
      response = await dio.get(apiHadistURL + searchHadist + query);
      if (response.statusCode == 200) {
        daftarSurat = DaftarHadist.fromJson(response.data);
      }
      dio.close();
      return daftarSurat;
    } on http_dio.DioError catch (e) {
      throw (e);
    }
  }
}
