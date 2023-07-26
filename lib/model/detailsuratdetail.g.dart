// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailsuratdetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailSuratDetail _$DetailSuratDetailFromJson(Map<String, dynamic> json) =>
    DetailSuratDetail(
      json['nomor'] as int,
      json['nama'] as String,
      json['namaLatin'] as String,
      json['jumlahAyat'] as int,
      json['tempatTurun'] as String,
      json['arti'] as String,
      json['deskripsi'] as String,
      json['audioFull'] as List<dynamic>,
      json['ayat'] as List<dynamic>,
      json['suratSelanjutnya'] as List<dynamic>,
      json['suratSebelumnya'] as List<dynamic>,
    );

Map<String, dynamic> _$DetailSuratDetailToJson(DetailSuratDetail instance) =>
    <String, dynamic>{
      'nomor': instance.nomor,
      'nama': instance.nama,
      'namaLatin': instance.namaLatin,
      'jumlahAyat': instance.jumlahAyat,
      'tempatTurun': instance.tempatTurun,
      'arti': instance.arti,
      'deskripsi': instance.deskripsi,
      'audioFull': instance.audioFull,
      'ayat': instance.ayat,
      'suratSelanjutnya': instance.suratSelanjutnya,
      'suratSebelumnya': instance.suratSebelumnya,
    };
