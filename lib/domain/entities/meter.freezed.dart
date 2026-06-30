// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Meter {
  int get id => throw _privateConstructorUsedError;
  int get concentratorId => throw _privateConstructorUsedError;
  String get serialNumber => throw _privateConstructorUsedError;
  String get accountNumber => throw _privateConstructorUsedError;
  MeterType get meterType =>
      throw _privateConstructorUsedError; // DLMS/COSEM server addressing
  int get logicalDeviceAddress =>
      throw _privateConstructorUsedError; // upper HDLC address (e.g. 1)
  int get physicalAddress =>
      throw _privateConstructorUsedError; // lower HDLC address (e.g. 17)
  int get clientAddress =>
      throw _privateConstructorUsedError; // client SAP — management: 0x10, public: 0x10
// DLMS security
  AuthLevel get authLevel => throw _privateConstructorUsedError;
  String? get password =>
      throw _privateConstructorUsedError; // low-level auth; AES-256 encrypted at rest
  String? get encryptionKey =>
      throw _privateConstructorUsedError; // 16-byte HEX; AES-256 encrypted at rest
  String? get authenticationKey =>
      throw _privateConstructorUsedError; // 16-byte HEX; AES-256 encrypted at rest
// Metadata
  String? get manufacturerId => throw _privateConstructorUsedError;
  String? get firmwareVersion => throw _privateConstructorUsedError;
  DateTime? get lastReadAt => throw _privateConstructorUsedError;
  DateTime? get installedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MeterCopyWith<Meter> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeterCopyWith<$Res> {
  factory $MeterCopyWith(Meter value, $Res Function(Meter) then) =
      _$MeterCopyWithImpl<$Res, Meter>;
  @useResult
  $Res call(
      {int id,
      int concentratorId,
      String serialNumber,
      String accountNumber,
      MeterType meterType,
      int logicalDeviceAddress,
      int physicalAddress,
      int clientAddress,
      AuthLevel authLevel,
      String? password,
      String? encryptionKey,
      String? authenticationKey,
      String? manufacturerId,
      String? firmwareVersion,
      DateTime? lastReadAt,
      DateTime? installedAt,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$MeterCopyWithImpl<$Res, $Val extends Meter>
    implements $MeterCopyWith<$Res> {
  _$MeterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? concentratorId = null,
    Object? serialNumber = null,
    Object? accountNumber = null,
    Object? meterType = null,
    Object? logicalDeviceAddress = null,
    Object? physicalAddress = null,
    Object? clientAddress = null,
    Object? authLevel = null,
    Object? password = freezed,
    Object? encryptionKey = freezed,
    Object? authenticationKey = freezed,
    Object? manufacturerId = freezed,
    Object? firmwareVersion = freezed,
    Object? lastReadAt = freezed,
    Object? installedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      concentratorId: null == concentratorId
          ? _value.concentratorId
          : concentratorId // ignore: cast_nullable_to_non_nullable
              as int,
      serialNumber: null == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String,
      accountNumber: null == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String,
      meterType: null == meterType
          ? _value.meterType
          : meterType // ignore: cast_nullable_to_non_nullable
              as MeterType,
      logicalDeviceAddress: null == logicalDeviceAddress
          ? _value.logicalDeviceAddress
          : logicalDeviceAddress // ignore: cast_nullable_to_non_nullable
              as int,
      physicalAddress: null == physicalAddress
          ? _value.physicalAddress
          : physicalAddress // ignore: cast_nullable_to_non_nullable
              as int,
      clientAddress: null == clientAddress
          ? _value.clientAddress
          : clientAddress // ignore: cast_nullable_to_non_nullable
              as int,
      authLevel: null == authLevel
          ? _value.authLevel
          : authLevel // ignore: cast_nullable_to_non_nullable
              as AuthLevel,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      encryptionKey: freezed == encryptionKey
          ? _value.encryptionKey
          : encryptionKey // ignore: cast_nullable_to_non_nullable
              as String?,
      authenticationKey: freezed == authenticationKey
          ? _value.authenticationKey
          : authenticationKey // ignore: cast_nullable_to_non_nullable
              as String?,
      manufacturerId: freezed == manufacturerId
          ? _value.manufacturerId
          : manufacturerId // ignore: cast_nullable_to_non_nullable
              as String?,
      firmwareVersion: freezed == firmwareVersion
          ? _value.firmwareVersion
          : firmwareVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      lastReadAt: freezed == lastReadAt
          ? _value.lastReadAt
          : lastReadAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      installedAt: freezed == installedAt
          ? _value.installedAt
          : installedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MeterImplCopyWith<$Res> implements $MeterCopyWith<$Res> {
  factory _$$MeterImplCopyWith(
          _$MeterImpl value, $Res Function(_$MeterImpl) then) =
      __$$MeterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int concentratorId,
      String serialNumber,
      String accountNumber,
      MeterType meterType,
      int logicalDeviceAddress,
      int physicalAddress,
      int clientAddress,
      AuthLevel authLevel,
      String? password,
      String? encryptionKey,
      String? authenticationKey,
      String? manufacturerId,
      String? firmwareVersion,
      DateTime? lastReadAt,
      DateTime? installedAt,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$MeterImplCopyWithImpl<$Res>
    extends _$MeterCopyWithImpl<$Res, _$MeterImpl>
    implements _$$MeterImplCopyWith<$Res> {
  __$$MeterImplCopyWithImpl(
      _$MeterImpl _value, $Res Function(_$MeterImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? concentratorId = null,
    Object? serialNumber = null,
    Object? accountNumber = null,
    Object? meterType = null,
    Object? logicalDeviceAddress = null,
    Object? physicalAddress = null,
    Object? clientAddress = null,
    Object? authLevel = null,
    Object? password = freezed,
    Object? encryptionKey = freezed,
    Object? authenticationKey = freezed,
    Object? manufacturerId = freezed,
    Object? firmwareVersion = freezed,
    Object? lastReadAt = freezed,
    Object? installedAt = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$MeterImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      concentratorId: null == concentratorId
          ? _value.concentratorId
          : concentratorId // ignore: cast_nullable_to_non_nullable
              as int,
      serialNumber: null == serialNumber
          ? _value.serialNumber
          : serialNumber // ignore: cast_nullable_to_non_nullable
              as String,
      accountNumber: null == accountNumber
          ? _value.accountNumber
          : accountNumber // ignore: cast_nullable_to_non_nullable
              as String,
      meterType: null == meterType
          ? _value.meterType
          : meterType // ignore: cast_nullable_to_non_nullable
              as MeterType,
      logicalDeviceAddress: null == logicalDeviceAddress
          ? _value.logicalDeviceAddress
          : logicalDeviceAddress // ignore: cast_nullable_to_non_nullable
              as int,
      physicalAddress: null == physicalAddress
          ? _value.physicalAddress
          : physicalAddress // ignore: cast_nullable_to_non_nullable
              as int,
      clientAddress: null == clientAddress
          ? _value.clientAddress
          : clientAddress // ignore: cast_nullable_to_non_nullable
              as int,
      authLevel: null == authLevel
          ? _value.authLevel
          : authLevel // ignore: cast_nullable_to_non_nullable
              as AuthLevel,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      encryptionKey: freezed == encryptionKey
          ? _value.encryptionKey
          : encryptionKey // ignore: cast_nullable_to_non_nullable
              as String?,
      authenticationKey: freezed == authenticationKey
          ? _value.authenticationKey
          : authenticationKey // ignore: cast_nullable_to_non_nullable
              as String?,
      manufacturerId: freezed == manufacturerId
          ? _value.manufacturerId
          : manufacturerId // ignore: cast_nullable_to_non_nullable
              as String?,
      firmwareVersion: freezed == firmwareVersion
          ? _value.firmwareVersion
          : firmwareVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      lastReadAt: freezed == lastReadAt
          ? _value.lastReadAt
          : lastReadAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      installedAt: freezed == installedAt
          ? _value.installedAt
          : installedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$MeterImpl implements _Meter {
  const _$MeterImpl(
      {required this.id,
      required this.concentratorId,
      required this.serialNumber,
      required this.accountNumber,
      required this.meterType,
      required this.logicalDeviceAddress,
      required this.physicalAddress,
      required this.clientAddress,
      required this.authLevel,
      this.password,
      this.encryptionKey,
      this.authenticationKey,
      this.manufacturerId,
      this.firmwareVersion,
      this.lastReadAt,
      this.installedAt,
      required this.createdAt,
      required this.updatedAt});

  @override
  final int id;
  @override
  final int concentratorId;
  @override
  final String serialNumber;
  @override
  final String accountNumber;
  @override
  final MeterType meterType;
// DLMS/COSEM server addressing
  @override
  final int logicalDeviceAddress;
// upper HDLC address (e.g. 1)
  @override
  final int physicalAddress;
// lower HDLC address (e.g. 17)
  @override
  final int clientAddress;
// client SAP — management: 0x10, public: 0x10
// DLMS security
  @override
  final AuthLevel authLevel;
  @override
  final String? password;
// low-level auth; AES-256 encrypted at rest
  @override
  final String? encryptionKey;
// 16-byte HEX; AES-256 encrypted at rest
  @override
  final String? authenticationKey;
// 16-byte HEX; AES-256 encrypted at rest
// Metadata
  @override
  final String? manufacturerId;
  @override
  final String? firmwareVersion;
  @override
  final DateTime? lastReadAt;
  @override
  final DateTime? installedAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Meter(id: $id, concentratorId: $concentratorId, serialNumber: $serialNumber, accountNumber: $accountNumber, meterType: $meterType, logicalDeviceAddress: $logicalDeviceAddress, physicalAddress: $physicalAddress, clientAddress: $clientAddress, authLevel: $authLevel, password: $password, encryptionKey: $encryptionKey, authenticationKey: $authenticationKey, manufacturerId: $manufacturerId, firmwareVersion: $firmwareVersion, lastReadAt: $lastReadAt, installedAt: $installedAt, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeterImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.concentratorId, concentratorId) ||
                other.concentratorId == concentratorId) &&
            (identical(other.serialNumber, serialNumber) ||
                other.serialNumber == serialNumber) &&
            (identical(other.accountNumber, accountNumber) ||
                other.accountNumber == accountNumber) &&
            (identical(other.meterType, meterType) ||
                other.meterType == meterType) &&
            (identical(other.logicalDeviceAddress, logicalDeviceAddress) ||
                other.logicalDeviceAddress == logicalDeviceAddress) &&
            (identical(other.physicalAddress, physicalAddress) ||
                other.physicalAddress == physicalAddress) &&
            (identical(other.clientAddress, clientAddress) ||
                other.clientAddress == clientAddress) &&
            (identical(other.authLevel, authLevel) ||
                other.authLevel == authLevel) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.encryptionKey, encryptionKey) ||
                other.encryptionKey == encryptionKey) &&
            (identical(other.authenticationKey, authenticationKey) ||
                other.authenticationKey == authenticationKey) &&
            (identical(other.manufacturerId, manufacturerId) ||
                other.manufacturerId == manufacturerId) &&
            (identical(other.firmwareVersion, firmwareVersion) ||
                other.firmwareVersion == firmwareVersion) &&
            (identical(other.lastReadAt, lastReadAt) ||
                other.lastReadAt == lastReadAt) &&
            (identical(other.installedAt, installedAt) ||
                other.installedAt == installedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      concentratorId,
      serialNumber,
      accountNumber,
      meterType,
      logicalDeviceAddress,
      physicalAddress,
      clientAddress,
      authLevel,
      password,
      encryptionKey,
      authenticationKey,
      manufacturerId,
      firmwareVersion,
      lastReadAt,
      installedAt,
      createdAt,
      updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$MeterImplCopyWith<_$MeterImpl> get copyWith =>
      __$$MeterImplCopyWithImpl<_$MeterImpl>(this, _$identity);
}

abstract class _Meter implements Meter {
  const factory _Meter(
      {required final int id,
      required final int concentratorId,
      required final String serialNumber,
      required final String accountNumber,
      required final MeterType meterType,
      required final int logicalDeviceAddress,
      required final int physicalAddress,
      required final int clientAddress,
      required final AuthLevel authLevel,
      final String? password,
      final String? encryptionKey,
      final String? authenticationKey,
      final String? manufacturerId,
      final String? firmwareVersion,
      final DateTime? lastReadAt,
      final DateTime? installedAt,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$MeterImpl;

  @override
  int get id;
  @override
  int get concentratorId;
  @override
  String get serialNumber;
  @override
  String get accountNumber;
  @override
  MeterType get meterType;
  @override // DLMS/COSEM server addressing
  int get logicalDeviceAddress;
  @override // upper HDLC address (e.g. 1)
  int get physicalAddress;
  @override // lower HDLC address (e.g. 17)
  int get clientAddress;
  @override // client SAP — management: 0x10, public: 0x10
// DLMS security
  AuthLevel get authLevel;
  @override
  String? get password;
  @override // low-level auth; AES-256 encrypted at rest
  String? get encryptionKey;
  @override // 16-byte HEX; AES-256 encrypted at rest
  String? get authenticationKey;
  @override // 16-byte HEX; AES-256 encrypted at rest
// Metadata
  String? get manufacturerId;
  @override
  String? get firmwareVersion;
  @override
  DateTime? get lastReadAt;
  @override
  DateTime? get installedAt;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$MeterImplCopyWith<_$MeterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
