part of 'network_tree_bloc.dart';

sealed class NetworkTreeEvent {}

final class LoadNetworkTree extends NetworkTreeEvent {}

final class ToggleGroupNode extends NetworkTreeEvent {
  final int? groupId; // null = ungrouped section
  ToggleGroupNode(this.groupId);
}

final class ToggleConcentratorNode extends NetworkTreeEvent {
  final int concentratorId;
  ToggleConcentratorNode(this.concentratorId);
}

final class DeleteConcentratorRequested extends NetworkTreeEvent {
  final int concentratorId;
  DeleteConcentratorRequested(this.concentratorId);
}

final class DeleteMeterRequested extends NetworkTreeEvent {
  final int meterId;
  DeleteMeterRequested(this.meterId);
}

final class AddGroupRequested extends NetworkTreeEvent {
  final String name;
  AddGroupRequested(this.name);
}
