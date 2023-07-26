// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailtafsirdetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailTafsirDetail _$DetailTafsirDetailFromJson(Map<String, dynamic> json) =>
    DetailTafsirDetail(
      json['nomor'] as int,
      json['nama'] as String,
      json['namaLatin'] as String,
      json['jumlahAyat'] as int,
      json['tempatTurun'] as String,
      json['arti'] as String,
      json['deskripsi'] as String,
      json['audioFull'] as List<dynamic>,
      json['tafsir'] as List<dynamic>,
      json['suratSelanjutnya'] as List<dynamic>,
      json['suratSebelumnya'] as List<dynamic>,
    );

Map<String, dynamic> _$DetailTafsirDetailToJson(DetailTafsirDetail instance) =>
    <String, dynamic>{
      'nomor': instance.nomor,
      'nama': instance.nama,
      'namaLatin': instance.namaLatin,
      'jumlahAyat': instance.jumlahAyat,
      'tempatTurun': instance.tempatTurun,
      'arti': instance.arti,
      'deskripsi': instance.deskripsi,
      'audioFull': instance.audioFull,
      'tafsir': instance.tafsir,
      'suratSelanjutnya': instance.suratSelanjutnya,
      'suratSebelumnya': instance.suratSebelumnya,
    };
