// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NetworkGroup {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NetworkGroupCopyWith<NetworkGroup> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkGroupCopyWith<$Res> {
  factory $NetworkGroupCopyWith(
          NetworkGroup value, $Res Function(NetworkGroup) then) =
      _$NetworkGroupCopyWithImpl<$Res, NetworkGroup>;
  @useResult
  $Res call({int id, String name, String? description, DateTime createdAt});
}

/// @nodoc
class _$NetworkGroupCopyWithImpl<$Res, $Val extends NetworkGroup>
    implements $NetworkGroupCopyWith<$Res> {
  _$NetworkGroupCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NetworkGroupImplCopyWith<$Res>
    implements $NetworkGroupCopyWith<$Res> {
  factory _$$NetworkGroupImplCopyWith(
          _$NetworkGroupImpl value, $Res Function(_$NetworkGroupImpl) then) =
      __$$NetworkGroupImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name, String? description, DateTime createdAt});
}

/// @nodoc
class __$$NetworkGroupImplCopyWithImpl<$Res>
    extends _$NetworkGroupCopyWithImpl<$Res, _$NetworkGroupImpl>
    implements _$$NetworkGroupImplCopyWith<$Res> {
  __$$NetworkGroupImplCopyWithImpl(
      _$NetworkGroupImpl _value, $Res Function(_$NetworkGroupImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$NetworkGroupImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$NetworkGroupImpl implements _NetworkGroup {
  const _$NetworkGroupImpl(
      {required this.id,
      required this.name,
      this.description,
      required this.createdAt});

  @override
  final int id;
  @override
  final String name;
  @override
  final String? description;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'NetworkGroup(id: $id, name: $name, description: $description, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NetworkGroupImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, description, createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NetworkGroupImplCopyWith<_$NetworkGroupImpl> get copyWith =>
      __$$NetworkGroupImplCopyWithImpl<_$NetworkGroupImpl>(this, _$identity);
}

abstract class _NetworkGroup implements NetworkGroup {
  const factory _NetworkGroup(
      {required final int id,
      required final String name,
      final String? description,
      required final DateTime createdAt}) = _$NetworkGroupImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  String? get description;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$NetworkGroupImplCopyWith<_$NetworkGroupImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
