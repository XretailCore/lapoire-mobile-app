// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'payment_frame_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FrameConfigModel _$FrameConfigModelFromJson(Map<String, dynamic> json) {
  return _FrameConfigModel.fromJson(json);
}

/// @nodoc
class _$FrameConfigModelTearOff {
  const _$FrameConfigModelTearOff();

  _FrameConfigModel call(
      {@JsonKey(name: 'token') String? token,
      @JsonKey(name: 'payment_gateway_reference_id') String? fawryId}) {
    return _FrameConfigModel(
      token: token,
      fawryId: fawryId,
    );
  }

  FrameConfigModel fromJson(Map<String, Object?> json) {
    return FrameConfigModel.fromJson(json);
  }
}

/// @nodoc
const $FrameConfigModel = _$FrameConfigModelTearOff();

/// @nodoc
mixin _$FrameConfigModel {
  @JsonKey(name: 'token')
  String? get token => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_gateway_reference_id')
  String? get fawryId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FrameConfigModelCopyWith<FrameConfigModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FrameConfigModelCopyWith<$Res> {
  factory $FrameConfigModelCopyWith(
          FrameConfigModel value, $Res Function(FrameConfigModel) then) =
      _$FrameConfigModelCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'token') String? token,
      @JsonKey(name: 'payment_gateway_reference_id') String? fawryId});
}

/// @nodoc
class _$FrameConfigModelCopyWithImpl<$Res>
    implements $FrameConfigModelCopyWith<$Res> {
  _$FrameConfigModelCopyWithImpl(this._value, this._then);

  final FrameConfigModel _value;
  // ignore: unused_field
  final $Res Function(FrameConfigModel) _then;

  @override
  $Res call({
    Object? token = freezed,
    Object? fawryId = freezed,
  }) {
    return _then(_value.copyWith(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      fawryId: fawryId == freezed
          ? _value.fawryId
          : fawryId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$FrameConfigModelCopyWith<$Res>
    implements $FrameConfigModelCopyWith<$Res> {
  factory _$FrameConfigModelCopyWith(
          _FrameConfigModel value, $Res Function(_FrameConfigModel) then) =
      __$FrameConfigModelCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'token') String? token,
      @JsonKey(name: 'payment_gateway_reference_id') String? fawryId});
}

/// @nodoc
class __$FrameConfigModelCopyWithImpl<$Res>
    extends _$FrameConfigModelCopyWithImpl<$Res>
    implements _$FrameConfigModelCopyWith<$Res> {
  __$FrameConfigModelCopyWithImpl(
      _FrameConfigModel _value, $Res Function(_FrameConfigModel) _then)
      : super(_value, (v) => _then(v as _FrameConfigModel));

  @override
  _FrameConfigModel get _value => super._value as _FrameConfigModel;

  @override
  $Res call({
    Object? token = freezed,
    Object? fawryId = freezed,
  }) {
    return _then(_FrameConfigModel(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      fawryId: fawryId == freezed
          ? _value.fawryId
          : fawryId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FrameConfigModel implements _FrameConfigModel {
  const _$_FrameConfigModel(
      {@JsonKey(name: 'token') this.token,
      @JsonKey(name: 'payment_gateway_reference_id') this.fawryId});

  factory _$_FrameConfigModel.fromJson(Map<String, dynamic> json) =>
      _$$_FrameConfigModelFromJson(json);

  @override
  @JsonKey(name: 'token')
  final String? token;
  @override
  @JsonKey(name: 'payment_gateway_reference_id')
  final String? fawryId;

  @override
  String toString() {
    return 'FrameConfigModel(token: $token, fawryId: $fawryId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FrameConfigModel &&
            const DeepCollectionEquality().equals(other.token, token) &&
            const DeepCollectionEquality().equals(other.fawryId, fawryId));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(token),
      const DeepCollectionEquality().hash(fawryId));

  @JsonKey(ignore: true)
  @override
  _$FrameConfigModelCopyWith<_FrameConfigModel> get copyWith =>
      __$FrameConfigModelCopyWithImpl<_FrameConfigModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FrameConfigModelToJson(this);
  }
}

abstract class _FrameConfigModel implements FrameConfigModel {
  const factory _FrameConfigModel(
          {@JsonKey(name: 'token') String? token,
          @JsonKey(name: 'payment_gateway_reference_id') String? fawryId}) =
      _$_FrameConfigModel;

  factory _FrameConfigModel.fromJson(Map<String, dynamic> json) =
      _$_FrameConfigModel.fromJson;

  @override
  @JsonKey(name: 'token')
  String? get token;
  @override
  @JsonKey(name: 'payment_gateway_reference_id')
  String? get fawryId;
  @override
  @JsonKey(ignore: true)
  _$FrameConfigModelCopyWith<_FrameConfigModel> get copyWith =>
      throw _privateConstructorUsedError;
}
