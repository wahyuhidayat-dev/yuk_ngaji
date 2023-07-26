import 'package:json_annotation/json_annotation.dart';

part 'daftarhadist.g.dart';

@JsonSerializable()
class DaftarHadist {
  @JsonKey(name: "items")
  final List items;

  @JsonKey(name: "meta")
  final Map<String, dynamic> meta;

  DaftarHadist(this.items, this.meta);

  factory DaftarHadist.fromJson(Map<String, dynamic> json) =>
      _$DaftarHadistFromJson(json);

  Map<String, dynamic> toJson() => _$DaftarHadistToJson(this);
}
