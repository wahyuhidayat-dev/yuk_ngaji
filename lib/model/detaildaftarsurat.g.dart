// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detaildaftarsurat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailDaftarSurat _$DetailDaftarSuratFromJson(Map<String, dynamic> json) =>
    DetailDaftarSurat(
      json['nomor'] as int,
      json['nama'] as String,
      json['namaLatin'] as String,
      json['jumlahAyat'] as int,
      json['tempatTurun'] as String,
      json['arti'] as String,
      json['deskripsi'] as String,
      json['audioFull'] as List<dynamic>,
    );

Map<String, dynamic> _$DetailDaftarSuratToJson(DetailDaftarSurat instance) =>
    <String, dynamic>{
      'nomor': instance.nomor,
      'nama': instance.nama,
      'namaLatin': instance.namaLatin,
      'jumlahAyat': instance.jumlahAyat,
      'tempatTurun': instance.tempatTurun,
      'arti': instance.arti,
      'deskripsi': instance.deskripsi,
      'audioFull': instance.audioFull,
    };
