// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_frame_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FrameConfigModel _$$_FrameConfigModelFromJson(Map<String, dynamic> json) =>
    _$_FrameConfigModel(
      token: json['token'] as String?,
      fawryId: json['payment_gateway_reference_id'] as String?,
    );

Map<String, dynamic> _$$_FrameConfigModelToJson(_$_FrameConfigModel instance) =>
    <String, dynamic>{
      'token': instance.token,
      'payment_gateway_reference_id': instance.fawryId,
    };
