import 'package:json_annotation/json_annotation.dart';

part 'detailsurat.g.dart';

@JsonSerializable()
class DetailSurat {
  @JsonKey(name: "code")
  final int code;

  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "data")
  final Map<String, dynamic> data;

  DetailSurat(this.code, this.message, this.data);

  factory DetailSurat.fromJson(Map<String, dynamic> json) =>
      _$DetailSuratFromJson(json);

  Map<String, dynamic> toJson() => _$DetailSuratToJson(this);
}
