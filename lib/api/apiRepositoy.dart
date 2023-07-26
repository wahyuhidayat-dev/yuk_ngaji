// ignore_for_file: file_names

import 'package:yuk_ngaji/api/apiProvider.dart';
import 'package:yuk_ngaji/model/daftarhadist.dart';
import 'package:yuk_ngaji/model/daftarsurat.dart';
import 'package:yuk_ngaji/model/detailsurat.dart';
import 'package:yuk_ngaji/model/detailtafsir.dart';

class ApiRepository {
  ApiProvider apiProvider = ApiProvider();
  Future<DaftarSurat> getSemuaDaftarSurat() => apiProvider.getDaftarSurat();
  Future<DaftarHadist> getSemuaDaftarHadist() => apiProvider.getDaftarHadist();
  Future<DaftarHadist> searchSemuaDaftarHadist(String data) =>
      apiProvider.searchDaftarHadist(data);
  Future<DetailSurat> getBacaanSurat(String id) =>
      apiProvider.getDetailSurat(id);
  Future<DetailTafsir> getBacaanTafsir(String id) =>
      apiProvider.getDetailTafsir(id);
}
