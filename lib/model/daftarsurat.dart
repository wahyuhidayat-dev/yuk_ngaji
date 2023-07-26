import 'package:json_annotation/json_annotation.dart';
// import 'package:yuk_ngaji/model/detaildaftarsurat.dart';
part 'daftarsurat.g.dart';

@JsonSerializable()
class DaftarSurat {
  @JsonKey(name: "code")
  final int code;
  @JsonKey(name: "message")
  final String message;
  @JsonKey(name: "data")
  final List data;

  DaftarSurat(this.code, this.message, this.data);

  factory DaftarSurat.fromJson(dynamic json) => _$DaftarSuratFromJson(json);

  Map<String, dynamic> toJson() => _$DaftarSuratToJson(this);
}
