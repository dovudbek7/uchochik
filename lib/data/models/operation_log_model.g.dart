// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_log_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOperationLogModelCollection on Isar {
  IsarCollection<OperationLogModel> get operationLogModels => this.collection();
}

const OperationLogModelSchema = CollectionSchema(
  name: r'OperationLogModel',
  id: 2068296800042495106,
  properties: {
    r'concentratorId': PropertySchema(
      id: 0,
      name: r'concentratorId',
      type: IsarType.long,
    ),
    r'durationMs': PropertySchema(
      id: 1,
      name: r'durationMs',
      type: IsarType.long,
    ),
    r'errorMessage': PropertySchema(
      id: 2,
      name: r'errorMessage',
      type: IsarType.string,
    ),
    r'meterId': PropertySchema(
      id: 3,
      name: r'meterId',
      type: IsarType.long,
    ),
    r'operation': PropertySchema(
      id: 4,
      name: r'operation',
      type: IsarType.string,
    ),
    r'requestHex': PropertySchema(
      id: 5,
      name: r'requestHex',
      type: IsarType.string,
    ),
    r'responseHex': PropertySchema(
      id: 6,
      name: r'responseHex',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 7,
      name: r'status',
      type: IsarType.byte,
      enumMap: _OperationLogModelstatusEnumValueMap,
    ),
    r'timestamp': PropertySchema(
      id: 8,
      name: r'timestamp',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _operationLogModelEstimateSize,
  serialize: _operationLogModelSerialize,
  deserialize: _operationLogModelDeserialize,
  deserializeProp: _operationLogModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'meterId': IndexSchema(
      id: -1596511903527871468,
      name: r'meterId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'meterId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'concentratorId': IndexSchema(
      id: -8373061806907438882,
      name: r'concentratorId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'concentratorId',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'timestamp': IndexSchema(
      id: 1852253767416892198,
      name: r'timestamp',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'timestamp',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _operationLogModelGetId,
  getLinks: _operationLogModelGetLinks,
  attach: _operationLogModelAttach,
  version: '3.1.0+1',
);

int _operationLogModelEstimateSize(
  OperationLogModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.errorMessage;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.operation.length * 3;
  {
    final value = object.requestHex;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.responseHex;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _operationLogModelSerialize(
  OperationLogModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.concentratorId);
  writer.writeLong(offsets[1], object.durationMs);
  writer.writeString(offsets[2], object.errorMessage);
  writer.writeLong(offsets[3], object.meterId);
  writer.writeString(offsets[4], object.operation);
  writer.writeString(offsets[5], object.requestHex);
  writer.writeString(offsets[6], object.responseHex);
  writer.writeByte(offsets[7], object.status.index);
  writer.writeDateTime(offsets[8], object.timestamp);
}

OperationLogModel _operationLogModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OperationLogModel();
  object.concentratorId = reader.readLong(offsets[0]);
  object.durationMs = reader.readLong(offsets[1]);
  object.errorMessage = reader.readStringOrNull(offsets[2]);
  object.id = id;
  object.meterId = reader.readLong(offsets[3]);
  object.operation = reader.readString(offsets[4]);
  object.requestHex = reader.readStringOrNull(offsets[5]);
  object.responseHex = reader.readStringOrNull(offsets[6]);
  object.status =
      _OperationLogModelstatusValueEnumMap[reader.readByteOrNull(offsets[7])] ??
          OperationStatus.pending;
  object.timestamp = reader.readDateTime(offsets[8]);
  return object;
}

P _operationLogModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (_OperationLogModelstatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          OperationStatus.pending) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _OperationLogModelstatusEnumValueMap = {
  'pending': 0,
  'success': 1,
  'failure': 2,
};
const _OperationLogModelstatusValueEnumMap = {
  0: OperationStatus.pending,
  1: OperationStatus.success,
  2: OperationStatus.failure,
};

Id _operationLogModelGetId(OperationLogModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _operationLogModelGetLinks(
    OperationLogModel object) {
  return [];
}

void _operationLogModelAttach(
    IsarCollection<dynamic> col, Id id, OperationLogModel object) {
  object.id = id;
}

extension OperationLogModelQueryWhereSort
    on QueryBuilder<OperationLogModel, OperationLogModel, QWhere> {
  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhere> anyMeterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'meterId'),
      );
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhere>
      anyConcentratorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'concentratorId'),
      );
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhere>
      anyTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'timestamp'),
      );
    });
  }
}

extension OperationLogModelQueryWhere
    on QueryBuilder<OperationLogModel, OperationLogModel, QWhereClause> {
  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      idBetween(
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

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      meterIdEqualTo(int meterId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'meterId',
        value: [meterId],
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      meterIdNotEqualTo(int meterId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'meterId',
              lower: [],
              upper: [meterId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'meterId',
              lower: [meterId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'meterId',
              lower: [meterId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'meterId',
              lower: [],
              upper: [meterId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      meterIdGreaterThan(
    int meterId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'meterId',
        lower: [meterId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      meterIdLessThan(
    int meterId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'meterId',
        lower: [],
        upper: [meterId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      meterIdBetween(
    int lowerMeterId,
    int upperMeterId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'meterId',
        lower: [lowerMeterId],
        includeLower: includeLower,
        upper: [upperMeterId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      concentratorIdEqualTo(int concentratorId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'concentratorId',
        value: [concentratorId],
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      concentratorIdNotEqualTo(int concentratorId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'concentratorId',
              lower: [],
              upper: [concentratorId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'concentratorId',
              lower: [concentratorId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'concentratorId',
              lower: [concentratorId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'concentratorId',
              lower: [],
              upper: [concentratorId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      concentratorIdGreaterThan(
    int concentratorId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'concentratorId',
        lower: [concentratorId],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      concentratorIdLessThan(
    int concentratorId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'concentratorId',
        lower: [],
        upper: [concentratorId],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      concentratorIdBetween(
    int lowerConcentratorId,
    int upperConcentratorId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'concentratorId',
        lower: [lowerConcentratorId],
        includeLower: includeLower,
        upper: [upperConcentratorId],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      timestampEqualTo(DateTime timestamp) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'timestamp',
        value: [timestamp],
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      timestampNotEqualTo(DateTime timestamp) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [],
              upper: [timestamp],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [timestamp],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [timestamp],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'timestamp',
              lower: [],
              upper: [timestamp],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      timestampGreaterThan(
    DateTime timestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'timestamp',
        lower: [timestamp],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      timestampLessThan(
    DateTime timestamp, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'timestamp',
        lower: [],
        upper: [timestamp],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterWhereClause>
      timestampBetween(
    DateTime lowerTimestamp,
    DateTime upperTimestamp, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'timestamp',
        lower: [lowerTimestamp],
        includeLower: includeLower,
        upper: [upperTimestamp],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension OperationLogModelQueryFilter
    on QueryBuilder<OperationLogModel, OperationLogModel, QFilterCondition> {
  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      concentratorIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'concentratorId',
        value: value,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
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

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
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

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
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

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      durationMsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationMs',
        value: value,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      durationMsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationMs',
        value: value,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      durationMsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationMs',
        value: value,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      durationMsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationMs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      errorMessageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'errorMessage',
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      errorMessageIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'errorMessage',
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      errorMessageEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'errorMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      errorMessageGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'errorMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      errorMessageLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'errorMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      errorMessageBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'errorMessage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      errorMessageStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'errorMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      errorMessageEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'errorMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      errorMessageContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'errorMessage',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      errorMessageMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'errorMessage',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      errorMessageIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'errorMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      errorMessageIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'errorMessage',
        value: '',
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      meterIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'meterId',
        value: value,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      meterIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'meterId',
        value: value,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      meterIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'meterId',
        value: value,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      meterIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'meterId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      operationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'operation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      operationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'operation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      operationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'operation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      operationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'operation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      operationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'operation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      operationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'operation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      operationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'operation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      operationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'operation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      operationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'operation',
        value: '',
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      operationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'operation',
        value: '',
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      requestHexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'requestHex',
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      requestHexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'requestHex',
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      requestHexEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requestHex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      requestHexGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'requestHex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      requestHexLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'requestHex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      requestHexBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'requestHex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      requestHexStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'requestHex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      requestHexEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'requestHex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      requestHexContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'requestHex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      requestHexMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'requestHex',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      requestHexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'requestHex',
        value: '',
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      requestHexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'requestHex',
        value: '',
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      responseHexIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'responseHex',
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      responseHexIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'responseHex',
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      responseHexEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'responseHex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      responseHexGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'responseHex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      responseHexLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'responseHex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      responseHexBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'responseHex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      responseHexStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'responseHex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      responseHexEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'responseHex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      responseHexContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'responseHex',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      responseHexMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'responseHex',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      responseHexIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'responseHex',
        value: '',
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      responseHexIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'responseHex',
        value: '',
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      statusEqualTo(OperationStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      statusGreaterThan(
    OperationStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      statusLessThan(
    OperationStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      statusBetween(
    OperationStatus lower,
    OperationStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      timestampEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      timestampGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      timestampLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterFilterCondition>
      timestampBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension OperationLogModelQueryObject
    on QueryBuilder<OperationLogModel, OperationLogModel, QFilterCondition> {}

extension OperationLogModelQueryLinks
    on QueryBuilder<OperationLogModel, OperationLogModel, QFilterCondition> {}

extension OperationLogModelQuerySortBy
    on QueryBuilder<OperationLogModel, OperationLogModel, QSortBy> {
  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      sortByConcentratorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'concentratorId', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      sortByConcentratorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'concentratorId', Sort.desc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      sortByDurationMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMs', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      sortByDurationMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMs', Sort.desc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      sortByErrorMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorMessage', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      sortByErrorMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorMessage', Sort.desc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      sortByMeterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meterId', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      sortByMeterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meterId', Sort.desc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      sortByOperation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operation', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      sortByOperationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operation', Sort.desc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      sortByRequestHex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestHex', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      sortByRequestHexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestHex', Sort.desc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      sortByResponseHex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'responseHex', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      sortByResponseHexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'responseHex', Sort.desc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension OperationLogModelQuerySortThenBy
    on QueryBuilder<OperationLogModel, OperationLogModel, QSortThenBy> {
  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByConcentratorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'concentratorId', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByConcentratorIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'concentratorId', Sort.desc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByDurationMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMs', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByDurationMsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationMs', Sort.desc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByErrorMessage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorMessage', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByErrorMessageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'errorMessage', Sort.desc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByMeterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meterId', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByMeterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'meterId', Sort.desc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByOperation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operation', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByOperationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'operation', Sort.desc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByRequestHex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestHex', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByRequestHexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'requestHex', Sort.desc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByResponseHex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'responseHex', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByResponseHexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'responseHex', Sort.desc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QAfterSortBy>
      thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension OperationLogModelQueryWhereDistinct
    on QueryBuilder<OperationLogModel, OperationLogModel, QDistinct> {
  QueryBuilder<OperationLogModel, OperationLogModel, QDistinct>
      distinctByConcentratorId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'concentratorId');
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QDistinct>
      distinctByDurationMs() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationMs');
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QDistinct>
      distinctByErrorMessage({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'errorMessage', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QDistinct>
      distinctByMeterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'meterId');
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QDistinct>
      distinctByOperation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'operation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QDistinct>
      distinctByRequestHex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'requestHex', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QDistinct>
      distinctByResponseHex({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'responseHex', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QDistinct>
      distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<OperationLogModel, OperationLogModel, QDistinct>
      distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }
}

extension OperationLogModelQueryProperty
    on QueryBuilder<OperationLogModel, OperationLogModel, QQueryProperty> {
  QueryBuilder<OperationLogModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<OperationLogModel, int, QQueryOperations>
      concentratorIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'concentratorId');
    });
  }

  QueryBuilder<OperationLogModel, int, QQueryOperations> durationMsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationMs');
    });
  }

  QueryBuilder<OperationLogModel, String?, QQueryOperations>
      errorMessageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'errorMessage');
    });
  }

  QueryBuilder<OperationLogModel, int, QQueryOperations> meterIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'meterId');
    });
  }

  QueryBuilder<OperationLogModel, String, QQueryOperations>
      operationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'operation');
    });
  }

  QueryBuilder<OperationLogModel, String?, QQueryOperations>
      requestHexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'requestHex');
    });
  }

  QueryBuilder<OperationLogModel, String?, QQueryOperations>
      responseHexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'responseHex');
    });
  }

  QueryBuilder<OperationLogModel, OperationStatus, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<OperationLogModel, DateTime, QQueryOperations>
      timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }
}
