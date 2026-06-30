// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meter_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMeterModelCollection on Isar {
  IsarCollection<MeterModel> get meterModels => this.collection();
}

const MeterModelSchema = CollectionSchema(
  name: r'MeterModel',
  id: 1595014502171224007,
  properties: {
    r'accountNumber': PropertySchema(
      id: 0,
      name: r'accountNumber',
      type: IsarType.string,
    ),
    r'authLevel': PropertySchema(
      id: 1,
      name: r'authLevel',
      type: IsarType.byte,
      enumMap: _MeterModelauthLevelEnumValueMap,
    ),
    r'authenticationKey': PropertySchema(
      id: 2,
      name: r'authenticationKey',
      type: IsarType.string,
    ),
    r'clientAddress': PropertySchema(
      id: 3,
      name: r'clientAddress',
      type: IsarType.long,
    ),
    r'concentratorId': PropertySchema(
      id: 4,
      name: r'concentratorId',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 5,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'encryptionKey': PropertySchema(
      id: 6,
      name: r'encryptionKey',
      type: IsarType.string,
    ),
    r'firmwareVersion': PropertySchema(
      id: 7,
      name: r'firmwareVersion',
      type: IsarType.string,
    ),
    r'installedAt': PropertySchema(
      id: 8,
      name: r'installedAt',
      type: IsarType.dateTime,
    ),
    r'lastReadAt': PropertySchema(
      id: 9,
      name: r'lastReadAt',
      type: IsarType.dateTime,
    ),
    r'logicalDeviceAddress': PropertySchema(
      id: 10,
      name: r'logicalDeviceAddress',
      type: IsarType.long,
    ),
    r'manufacturerId': PropertySchema(
      id: 11,
      name: r'manufacturerId',
      type: IsarType.string,
    ),
    r'meterType': PropertySchema(
      id: 12,
      name: r'meterType',
      type: IsarType.byte,
      enumMap: _MeterModelmeterTypeEnumValueMap,
    ),
    r'password': PropertySchema(
      id: 13,
      name: r'password',
      type: IsarType.string,
    ),
    r'physicalAddress': PropertySchema(
      id: 14,
      name: r'physicalAddress',
      type: IsarType.long,
    ),
    r'serialNumber': PropertySchema(
      id: 15,
      name: r'serialNumber',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 16,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _meterModelEstimateSize,
  serialize: _meterModelSerialize,
  deserialize: _meterModelDeserialize,
  deserializeProp: _meterModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'serialNumber': IndexSchema(
      id: 135203776617746534,
      name: r'serialNumber',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'serialNumber',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'accountNumber': IndexSchema(
      id: -3113303652791322435,
      name: r'accountNumber',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'accountNumber',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _meterModelGetId,
  getLinks: _meterModelGetLinks,
  attach: _meterModelAttach,
  version: '3.1.0+1',
);

int _meterModelEstimateSize(
  MeterModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.accountNumber.length * 3;
  {
    final value = object.authenticationKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.encryptionKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.firmwareVersion;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.manufacturerId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.password;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.serialNumber.length * 3;
  return bytesCount;
}

void _meterModelSerialize(
  MeterModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.accountNumber);
  writer.writeByte(offsets[1], object.authLevel.index);
  writer.writeString(offsets[2], object.authenticationKey);
  writer.writeLong(offsets[3], object.clientAddress);
  writer.writeLong(offsets[4], object.concentratorId);
  writer.writeDateTime(offsets[5], object.createdAt);
  writer.writeString(offsets[6], object.encryptionKey);
  writer.writeString(offsets[7], object.firmwareVersion);
  writer.writeDateTime(offsets[8], object.installedAt);
  writer.writeDateTime(offsets[9], object.lastReadAt);
  writer.writeLong(offsets[10], object.logicalDeviceAddress);
  writer.writeString(offsets[11], object.manufacturerId);
  writer.writeByte(offsets[12], object.meterType.index);
  writer.writeString(offsets[13], object.password);
  writer.writeLong(offsets[14], object.physicalAddress);
  writer.writeString(offsets[15], object.serialNumber);
  writer.writeDateTime(offsets[16], object.updatedAt);
}

MeterModel _meterModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MeterModel();
  object.accountNumber = reader.readString(offsets[0]);
  object.authLevel =
      _MeterModelauthLevelValueEnumMap[reader.readByteOrNull(offsets[1])] ??
          AuthLevel.none;
  object.authenticationKey = reader.readStringOrNull(offsets[2]);
  object.clientAddress = reader.readLong(offsets[3]);
  object.concentratorId = reader.readLong(offsets[4]);
  object.createdAt = reader.readDateTime(offsets[5]);
  object.encryptionKey = reader.readStringOrNull(offsets[6]);
  object.firmwareVersion = reader.readStringOrNull(offsets[7]);
  object.id = id;
  object.installedAt = reader.readDateTimeOrNull(offsets[8]);
  object.lastReadAt = reader.readDateTimeOrNull(offsets[9]);
  object.logicalDeviceAddress = reader.readLong(offsets[10]);
  object.manufacturerId = reader.readStringOrNull(offsets[11]);
  object.meterType =
      _MeterModelmeterTypeValueEnumMap[reader.readByteOrNull(offsets[12])] ??
          MeterType.electricity;
  object.password = reader.readStringOrNull(offsets[13]);
  object.physicalAddress = reader.readLong(offsets[14]);
  object.serialNumber = reader.readString(offsets[15]);
  object.updatedAt = reader.readDateTime(offsets[16]);
  return object;
}

P _meterModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (_MeterModelauthLevelValueEnumMap[reader.readByteOrNull(offset)] ??
          AuthLevel.none) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 9:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    case 12:
      return (_MeterModelmeterTypeValueEnumMap[reader.readByteOrNull(offset)] ??
          MeterType.electricity) as P;
    case 13:
      return (reader.readStringOrNull(offset)) as P;
    case 14:
      return (reader.readLong(offset)) as P;
    case 15:
      return (reader.readString(offset)) as P;
    case 16:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MeterModelauthLevelEnumValueMap = {
  'none': 0,
  'low': 1,
  'high': 2,
};
const _MeterModelauthLevelValueEnumMap = {
  0: AuthLevel.none,
  1: AuthLevel.low,
  2: AuthLevel.high,
};
const _MeterModelmeterTypeEnumValueMap = {
  'electricity': 0,
  'gas': 1,
  'water': 2,
};
const _MeterModelmeterTypeValueEnumMap = {
  0: MeterType.electricity,
  1: MeterType.gas,
  2: MeterType.water,
};

Id _meterModelGetId(MeterModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _meterModelGetLinks(MeterModel object) {
  return [];
}

void _meterModelAttach(IsarCollection<dynamic> col, Id id, MeterModel object) {
  object.id = id;
}

extension MeterModelQueryWhereSort
    on QueryBuilder<MeterModel, MeterModel, QWhere> {
  QueryBuilder<MeterModel, MeterModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MeterModelQueryWhere
    on QueryBuilder<MeterModel, MeterModel, QWhereClause> {
  QueryBuilder<MeterModel, MeterModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterWhereClause> serialNumberEqualTo(
      String serialNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'serialNumber',
        value: [serialNumber],
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterWhereClause>
      serialNumberNotEqualTo(String serialNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'serialNumber',
              lower: [],
              upper: [serialNumber],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'serialNumber',
              lower: [serialNumber],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'serialNumber',
              lower: [serialNumber],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'serialNumber',
              lower: [],
              upper: [serialNumber],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterWhereClause> accountNumberEqualTo(
      String accountNumber) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'accountNumber',
        value: [accountNumber],
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterWhereClause>
      accountNumberNotEqualTo(String accountNumber) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountNumber',
              lower: [],
              upper: [accountNumber],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountNumber',
              lower: [accountNumber],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountNumber',
              lower: [accountNumber],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'accountNumber',
              lower: [],
              upper: [accountNumber],
              includeUpper: false,
            ));
      }
    });
  }
}

extension MeterModelQueryFilter
    on QueryBuilder<MeterModel, MeterModel, QFilterCondition> {
  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      accountNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      accountNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'accountNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      accountNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'accountNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      accountNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'accountNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      accountNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'accountNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      accountNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'accountNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      accountNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'accountNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      accountNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'accountNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      accountNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'accountNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      accountNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'accountNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> authLevelEqualTo(
      AuthLevel value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'authLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      authLevelGreaterThan(
    AuthLevel value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'authLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> authLevelLessThan(
    AuthLevel value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'authLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> authLevelBetween(
    AuthLevel lower,
    AuthLevel upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'authLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      authenticationKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'authenticationKey',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      authenticationKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'authenticationKey',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      authenticationKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'authenticationKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      authenticationKeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'authenticationKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      authenticationKeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'authenticationKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      authenticationKeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'authenticationKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      authenticationKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'authenticationKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      authenticationKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'authenticationKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      authenticationKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'authenticationKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      authenticationKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'authenticationKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      authenticationKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'authenticationKey',
        value: '',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      authenticationKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'authenticationKey',
        value: '',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      clientAddressEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clientAddress',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      clientAddressGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clientAddress',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      clientAddressLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clientAddress',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      clientAddressBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clientAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      concentratorIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'concentratorId',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      concentratorIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'concentratorId',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      concentratorIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'concentratorId',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      concentratorIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'concentratorId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      encryptionKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'encryptionKey',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      encryptionKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'encryptionKey',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      encryptionKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptionKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      encryptionKeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'encryptionKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      encryptionKeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'encryptionKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      encryptionKeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'encryptionKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      encryptionKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'encryptionKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      encryptionKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'encryptionKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      encryptionKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'encryptionKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      encryptionKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'encryptionKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      encryptionKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'encryptionKey',
        value: '',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      encryptionKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'encryptionKey',
        value: '',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      firmwareVersionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'firmwareVersion',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      firmwareVersionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'firmwareVersion',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      firmwareVersionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firmwareVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      firmwareVersionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firmwareVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      firmwareVersionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firmwareVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      firmwareVersionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firmwareVersion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      firmwareVersionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firmwareVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      firmwareVersionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firmwareVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      firmwareVersionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firmwareVersion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      firmwareVersionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firmwareVersion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      firmwareVersionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firmwareVersion',
        value: '',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      firmwareVersionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firmwareVersion',
        value: '',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      installedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'installedAt',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      installedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'installedAt',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      installedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'installedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      installedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'installedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      installedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'installedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      installedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'installedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      lastReadAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastReadAt',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      lastReadAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastReadAt',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> lastReadAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastReadAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      lastReadAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastReadAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      lastReadAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastReadAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> lastReadAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastReadAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      logicalDeviceAddressEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'logicalDeviceAddress',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      logicalDeviceAddressGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'logicalDeviceAddress',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      logicalDeviceAddressLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'logicalDeviceAddress',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      logicalDeviceAddressBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'logicalDeviceAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      manufacturerIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'manufacturerId',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      manufacturerIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'manufacturerId',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      manufacturerIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'manufacturerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      manufacturerIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'manufacturerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      manufacturerIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'manufacturerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      manufacturerIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'manufacturerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      manufacturerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'manufacturerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      manufacturerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'manufacturerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      manufacturerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'manufacturerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      manufacturerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'manufacturerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      manufacturerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'manufacturerId',
        value: '',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      manufacturerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'manufacturerId',
        value: '',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> meterTypeEqualTo(
      MeterType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meterType',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      meterTypeGreaterThan(
    MeterType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'meterType',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> meterTypeLessThan(
    MeterType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'meterType',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> meterTypeBetween(
    MeterType lower,
    MeterType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'meterType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> passwordIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'password',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      passwordIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'password',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> passwordEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      passwordGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> passwordLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> passwordBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'password',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      passwordStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> passwordEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> passwordContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'password',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> passwordMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'password',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      passwordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'password',
        value: '',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      passwordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'password',
        value: '',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      physicalAddressEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'physicalAddress',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      physicalAddressGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'physicalAddress',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      physicalAddressLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'physicalAddress',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      physicalAddressBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'physicalAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      serialNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serialNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      serialNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'serialNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      serialNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'serialNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      serialNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'serialNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      serialNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'serialNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      serialNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'serialNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      serialNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'serialNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      serialNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'serialNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      serialNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'serialNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      serialNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'serialNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> updatedAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterFilterCondition> updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension MeterModelQueryObject
    on QueryBuilder<MeterModel, MeterModel, QFilterCondition> {}

extension MeterModelQueryLinks
    on QueryBuilder<MeterModel, MeterModel, QFilterCondition> {}

extension MeterModelQuerySortBy
    on QueryBuilder<MeterModel, MeterModel, QSortBy> {
  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByAccountNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNumber', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByAccountNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNumber', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByAuthLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authLevel', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByAuthLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authLevel', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByAuthenticationKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authenticationKey', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy>
      sortByAuthenticationKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authenticationKey', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByClientAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientAddress', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByClientAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientAddress', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByConcentratorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'concentratorId', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy>
      sortByConcentratorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'concentratorId', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByEncryptionKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encryptionKey', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByEncryptionKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encryptionKey', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByFirmwareVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firmwareVersion', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy>
      sortByFirmwareVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firmwareVersion', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByInstalledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installedAt', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByInstalledAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installedAt', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByLastReadAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadAt', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByLastReadAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadAt', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy>
      sortByLogicalDeviceAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logicalDeviceAddress', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy>
      sortByLogicalDeviceAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logicalDeviceAddress', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByManufacturerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manufacturerId', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy>
      sortByManufacturerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manufacturerId', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByMeterType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meterType', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByMeterTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meterType', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByPhysicalAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'physicalAddress', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy>
      sortByPhysicalAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'physicalAddress', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortBySerialNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serialNumber', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortBySerialNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serialNumber', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension MeterModelQuerySortThenBy
    on QueryBuilder<MeterModel, MeterModel, QSortThenBy> {
  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByAccountNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNumber', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByAccountNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'accountNumber', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByAuthLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authLevel', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByAuthLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authLevel', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByAuthenticationKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authenticationKey', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy>
      thenByAuthenticationKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'authenticationKey', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByClientAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientAddress', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByClientAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clientAddress', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByConcentratorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'concentratorId', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy>
      thenByConcentratorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'concentratorId', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByEncryptionKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encryptionKey', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByEncryptionKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'encryptionKey', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByFirmwareVersion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firmwareVersion', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy>
      thenByFirmwareVersionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firmwareVersion', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByInstalledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installedAt', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByInstalledAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'installedAt', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByLastReadAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadAt', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByLastReadAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastReadAt', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy>
      thenByLogicalDeviceAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logicalDeviceAddress', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy>
      thenByLogicalDeviceAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'logicalDeviceAddress', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByManufacturerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manufacturerId', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy>
      thenByManufacturerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'manufacturerId', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByMeterType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meterType', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByMeterTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meterType', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByPassword() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByPasswordDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'password', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByPhysicalAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'physicalAddress', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy>
      thenByPhysicalAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'physicalAddress', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenBySerialNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serialNumber', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenBySerialNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'serialNumber', Sort.desc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension MeterModelQueryWhereDistinct
    on QueryBuilder<MeterModel, MeterModel, QDistinct> {
  QueryBuilder<MeterModel, MeterModel, QDistinct> distinctByAccountNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'accountNumber',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QDistinct> distinctByAuthLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'authLevel');
    });
  }

  QueryBuilder<MeterModel, MeterModel, QDistinct> distinctByAuthenticationKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'authenticationKey',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QDistinct> distinctByClientAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clientAddress');
    });
  }

  QueryBuilder<MeterModel, MeterModel, QDistinct> distinctByConcentratorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'concentratorId');
    });
  }

  QueryBuilder<MeterModel, MeterModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<MeterModel, MeterModel, QDistinct> distinctByEncryptionKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'encryptionKey',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QDistinct> distinctByFirmwareVersion(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firmwareVersion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QDistinct> distinctByInstalledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'installedAt');
    });
  }

  QueryBuilder<MeterModel, MeterModel, QDistinct> distinctByLastReadAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastReadAt');
    });
  }

  QueryBuilder<MeterModel, MeterModel, QDistinct>
      distinctByLogicalDeviceAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'logicalDeviceAddress');
    });
  }

  QueryBuilder<MeterModel, MeterModel, QDistinct> distinctByManufacturerId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'manufacturerId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QDistinct> distinctByMeterType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'meterType');
    });
  }

  QueryBuilder<MeterModel, MeterModel, QDistinct> distinctByPassword(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'password', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QDistinct> distinctByPhysicalAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'physicalAddress');
    });
  }

  QueryBuilder<MeterModel, MeterModel, QDistinct> distinctBySerialNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'serialNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MeterModel, MeterModel, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension MeterModelQueryProperty
    on QueryBuilder<MeterModel, MeterModel, QQueryProperty> {
  QueryBuilder<MeterModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MeterModel, String, QQueryOperations> accountNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'accountNumber');
    });
  }

  QueryBuilder<MeterModel, AuthLevel, QQueryOperations> authLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'authLevel');
    });
  }

  QueryBuilder<MeterModel, String?, QQueryOperations>
      authenticationKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'authenticationKey');
    });
  }

  QueryBuilder<MeterModel, int, QQueryOperations> clientAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clientAddress');
    });
  }

  QueryBuilder<MeterModel, int, QQueryOperations> concentratorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'concentratorId');
    });
  }

  QueryBuilder<MeterModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<MeterModel, String?, QQueryOperations> encryptionKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'encryptionKey');
    });
  }

  QueryBuilder<MeterModel, String?, QQueryOperations>
      firmwareVersionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firmwareVersion');
    });
  }

  QueryBuilder<MeterModel, DateTime?, QQueryOperations> installedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'installedAt');
    });
  }

  QueryBuilder<MeterModel, DateTime?, QQueryOperations> lastReadAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastReadAt');
    });
  }

  QueryBuilder<MeterModel, int, QQueryOperations>
      logicalDeviceAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'logicalDeviceAddress');
    });
  }

  QueryBuilder<MeterModel, String?, QQueryOperations> manufacturerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'manufacturerId');
    });
  }

  QueryBuilder<MeterModel, MeterType, QQueryOperations> meterTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'meterType');
    });
  }

  QueryBuilder<MeterModel, String?, QQueryOperations> passwordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'password');
    });
  }

  QueryBuilder<MeterModel, int, QQueryOperations> physicalAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'physicalAddress');
    });
  }

  QueryBuilder<MeterModel, String, QQueryOperations> serialNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'serialNumber');
    });
  }

  QueryBuilder<MeterModel, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}
