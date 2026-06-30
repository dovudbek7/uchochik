import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uchochik/domain/entities/concentrator.dart';
import 'package:uchochik/domain/entities/meter.dart';
import 'package:uchochik/domain/entities/network_group.dart';
import 'package:uchochik/domain/repositories/i_concentrator_repository.dart';
import 'package:uchochik/domain/repositories/i_meter_repository.dart';
import 'package:uchochik/domain/repositories/i_network_group_repository.dart';

part 'network_tree_event.dart';
part 'network_tree_state.dart';

class NetworkTreeBloc extends Bloc<NetworkTreeEvent, NetworkTreeState> {
  NetworkTreeBloc({
    required IConcentratorRepository concentratorRepository,
    required IMeterRepository meterRepository,
    required INetworkGroupRepository groupRepository,
  })  : _concentratorRepo = concentratorRepository,
        _meterRepo = meterRepository,
        _groupRepo = groupRepository,
        super(const NetworkTreeState(isLoading: true)) {
    on<LoadNetworkTree>(_onLoad);
    on<ToggleGroupNode>(_onToggleGroup);
    on<ToggleConcentratorNode>(_onToggleConcentrator);
    on<DeleteConcentratorRequested>(_onDeleteConcentrator);
    on<DeleteMeterRequested>(_onDeleteMeter);
    on<AddGroupRequested>(_onAddGroup);
  }

  final IConcentratorRepository _concentratorRepo;
  final IMeterRepository _meterRepo;
  final INetworkGroupRepository _groupRepo;

  Future<void> _onLoad(
    LoadNetworkTree event,
    Emitter<NetworkTreeState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final groups = await _groupRepo.getAll();
      final allConcentrators = await _concentratorRepo.getAll();

      // Load meters for each concentrator
      final concentratorNodes = <ConcentratorNode>[];
      for (final c in allConcentrators) {
        final meters = await _meterRepo.getByConcentrator(c.id);
        concentratorNodes.add(ConcentratorNode(concentrator: c, meters: meters));
      }

      // Group concentrators
      final groupNodes = <GroupNode>[];

      for (final group in groups) {
        final inGroup = concentratorNodes
            .where((n) => n.concentrator.networkGroupId == group.id)
            .toList();
        groupNodes.add(GroupNode(group: group, concentrators: inGroup));
      }

      // Ungrouped section
      final ungrouped = concentratorNodes
          .where((n) => n.concentrator.networkGroupId == null)
          .toList();
      if (ungrouped.isNotEmpty || groups.isEmpty) {
        groupNodes.add(GroupNode(concentrators: ungrouped));
      }

      emit(state.copyWith(groups: groupNodes, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  void _onToggleGroup(ToggleGroupNode event, Emitter<NetworkTreeState> emit) {
    final updated = state.groups.map((g) {
      if (g.groupId == event.groupId) return g.copyWith(isExpanded: !g.isExpanded);
      return g;
    }).toList();
    emit(state.copyWith(groups: updated));
  }

  void _onToggleConcentrator(
    ToggleConcentratorNode event,
    Emitter<NetworkTreeState> emit,
  ) {
    final updated = state.groups.map((g) {
      final concentrators = g.concentrators.map((c) {
        if (c.concentrator.id == event.concentratorId) {
          return c.copyWith(isExpanded: !c.isExpanded);
        }
        return c;
      }).toList();
      return g.copyWith(concentrators: concentrators);
    }).toList();
    emit(state.copyWith(groups: updated));
  }

  Future<void> _onDeleteConcentrator(
    DeleteConcentratorRequested event,
    Emitter<NetworkTreeState> emit,
  ) async {
    await _concentratorRepo.delete(event.concentratorId);
    add(LoadNetworkTree());
  }

  Future<void> _onDeleteMeter(
    DeleteMeterRequested event,
    Emitter<NetworkTreeState> emit,
  ) async {
    await _meterRepo.delete(event.meterId);
    add(LoadNetworkTree());
  }

  Future<void> _onAddGroup(
    AddGroupRequested event,
    Emitter<NetworkTreeState> emit,
  ) async {
    final group = NetworkGroup(
      id: 0,
      name: event.name,
      createdAt: DateTime.now(),
    );
    await _groupRepo.save(group);
    add(LoadNetworkTree());
  }
}
