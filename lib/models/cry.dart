import 'package:json_annotation/json_annotation.dart';

part 'cry.g.dart';

@JsonSerializable()
class Cry {
  /// The generated code assumes these values exist in JSON.
  final String parentEmail, reason;
  final DateTime dateTime;

  Cry({required this.parentEmail, required this.reason, required this.dateTime});

  /// Connect the generated [_$CryFromJson] function to the `fromJson`
  /// factory.
  factory Cry.fromJson(Map<String, dynamic> json) => _$CryFromJson(json);

  /// Connect the generated [_$CryToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CryToJson(this);
}
