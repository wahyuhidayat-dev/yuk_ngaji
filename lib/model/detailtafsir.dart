import 'package:json_annotation/json_annotation.dart';

part 'detailtafsir.g.dart';

@JsonSerializable()
class DetailTafsir {
  @JsonKey(name: "code")
  final int code;

  @JsonKey(name: "message")
  final String message;

  @JsonKey(name: "data")
  final Map<String, dynamic> data;

  DetailTafsir(this.code, this.message, this.data);

  factory DetailTafsir.fromJson(Map<String, dynamic> json) =>
      _$DetailTafsirFromJson(json);

  Map<String, dynamic> toJson() => _$DetailTafsirToJson(this);
}
