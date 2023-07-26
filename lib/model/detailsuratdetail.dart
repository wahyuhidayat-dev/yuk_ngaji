import 'package:json_annotation/json_annotation.dart';

part 'detailsuratdetail.g.dart';

@JsonSerializable()
class DetailSuratDetail {
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

  @JsonKey(name: "ayat")
  final List ayat;

  @JsonKey(name: "suratSelanjutnya")
  final List suratSelanjutnya;

  @JsonKey(name: "suratSebelumnya")
  final List suratSebelumnya;

  DetailSuratDetail(
      this.nomor,
      this.nama,
      this.namaLatin,
      this.jumlahAyat,
      this.tempatTurun,
      this.arti,
      this.deskripsi,
      this.audioFull,
      this.ayat,
      this.suratSelanjutnya,
      this.suratSebelumnya);

  factory DetailSuratDetail.fromJson(Map<String, dynamic> json) =>
      _$DetailSuratDetailFromJson(json);

  Map<String, dynamic> toJson() => _$DetailSuratDetailToJson(this);
}
