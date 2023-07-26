import 'package:json_annotation/json_annotation.dart';

part 'detailtafsirdetail.g.dart';

@JsonSerializable()
class DetailTafsirDetail {
  @JsonKey(name: "nomor")
  final int nomor;

  @JsonKey(name: "nama")
  final String nama;

  @JsonKey(name: "namaLatin")
  final String namaLatin;

  @JsonKey(name: "jumlahAyat")
  final int jumlahAyat;

  @JsonKey(name: "tempatTurun")
  final String tempatTurun;

  @JsonKey(name: "arti")
  final String arti;

  @JsonKey(name: "deskripsi")
  final String deskripsi;

  @JsonKey(name: "audioFull")
  final List audioFull;

  @JsonKey(name: "tafsir")
  final List tafsir;

  @JsonKey(name: "suratSelanjutnya")
  final List suratSelanjutnya;

  @JsonKey(name: "suratSebelumnya")
  final List suratSebelumnya;

  DetailTafsirDetail(
      this.nomor,
      this.nama,
      this.namaLatin,
      this.jumlahAyat,
      this.tempatTurun,
      this.arti,
      this.deskripsi,
      this.audioFull,
      this.tafsir,
      this.suratSelanjutnya,
      this.suratSebelumnya);

  factory DetailTafsirDetail.fromJson(Map<String, dynamic> json) =>
      _$DetailTafsirDetailFromJson(json);

  Map<String, dynamic> toJson() => _$DetailTafsirDetailToJson(this);
}
