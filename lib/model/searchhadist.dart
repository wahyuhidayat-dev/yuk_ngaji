import 'package:json_annotation/json_annotation.dart';

part 'searchhadist.g.dart';

@JsonSerializable()
class SearchHadist {
  @JsonKey(name: "items")
  final List items;

  @JsonKey(name: "meta")
  final List meta;

  SearchHadist(this.items, this.meta);
  factory SearchHadist.fromJson(Map<String, dynamic> json) =>
      _$SearchHadistFromJson(json);

  Map<String, dynamic> toJson() => _$SearchHadistToJson(this);
}
