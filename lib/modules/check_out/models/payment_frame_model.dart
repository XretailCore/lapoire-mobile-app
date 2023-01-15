// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_frame_model.freezed.dart';
part 'payment_frame_model.g.dart';

@freezed
class FrameConfigModel with _$FrameConfigModel {
  const factory FrameConfigModel({
    @JsonKey(name: 'token') String? token,
    @JsonKey(name: 'payment_gateway_reference_id') String? fawryId,
  }) = _FrameConfigModel;

  factory FrameConfigModel.fromJson(Map<String, dynamic> json) =>
      _$FrameConfigModelFromJson(json);
}
