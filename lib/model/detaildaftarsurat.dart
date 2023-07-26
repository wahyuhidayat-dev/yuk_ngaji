import 'package:json_annotation/json_annotation.dart';

part 'detaildaftarsurat.g.dart';

@JsonSerializable()
class DetailDaftarSurat {
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

  DetailDaftarSurat(this.nomor, this.nama, this.namaLatin, this.jumlahAyat,
      this.tempatTurun, this.arti, this.deskripsi, this.audioFull);

  factory DetailDaftarSurat.fromJson(Map<String, dynamic> json) =>
      _$DetailDaftarSuratFromJson(json);

  Map<String, dynamic> toJson() => _$DetailDaftarSuratToJson(this);
}
