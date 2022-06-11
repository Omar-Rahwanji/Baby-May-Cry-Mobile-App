// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cry _$CryFromJson(Map<String, dynamic> json) => Cry(
      parentEmail: json['parentEmail'] as String,
      reason: json['reason'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
    );

Map<String, dynamic> _$CryToJson(Cry instance) => <String, dynamic>{
      'parentEmail': instance.parentEmail,
      'reason': instance.reason,
      'dateTime': instance.dateTime.toIso8601String(),
    };
