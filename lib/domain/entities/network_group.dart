import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_group.freezed.dart';

@freezed
class NetworkGroup with _$NetworkGroup {
  const factory NetworkGroup({
    required int id,
    required String name,
    String? description,
    required DateTime createdAt,
  }) = _NetworkGroup;
}
