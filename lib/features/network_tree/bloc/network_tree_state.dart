part of 'network_tree_bloc.dart';

/// Presentation-layer tree nodes — not domain entities.
class ConcentratorNode {
  const ConcentratorNode({
    required this.concentrator,
    this.meters = const [],
    this.isExpanded = false,
  });
  final Concentrator concentrator;
  final List<Meter> meters;
  final bool isExpanded;

  ConcentratorNode copyWith({
    Concentrator? concentrator,
    List<Meter>? meters,
    bool? isExpanded,
  }) => ConcentratorNode(
        concentrator: concentrator ?? this.concentrator,
        meters: meters ?? this.meters,
        isExpanded: isExpanded ?? this.isExpanded,
      );
}

class GroupNode {
  const GroupNode({
    this.group, // null = ungrouped
    this.concentrators = const [],
    this.isExpanded = true,
  });
  final NetworkGroup? group;
  final List<ConcentratorNode> concentrators;
  final bool isExpanded;

  int? get groupId => group?.id;

  GroupNode copyWith({
    NetworkGroup? group,
    List<ConcentratorNode>? concentrators,
    bool? isExpanded,
  }) => GroupNode(
        group: group ?? this.group,
        concentrators: concentrators ?? this.concentrators,
        isExpanded: isExpanded ?? this.isExpanded,
      );
}

class NetworkTreeState extends Equatable {
  const NetworkTreeState({
    this.groups = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  final List<GroupNode> groups;
  final bool isLoading;
  final String? errorMessage;

  bool get isEmpty =>
      groups.isEmpty ||
      groups.every((g) => g.concentrators.isEmpty);

  NetworkTreeState copyWith({
    List<GroupNode>? groups,
    bool? isLoading,
    String? errorMessage,
  }) => NetworkTreeState(
        groups: groups ?? this.groups,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage,
      );

  @override
  List<Object?> get props => [groups, isLoading, errorMessage];
}
