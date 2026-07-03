import 'package:get_it/get_it.dart';
import 'package:uchochik/data/local/datasources/concentrator_datasource.dart';
import 'package:uchochik/data/local/datasources/meter_datasource.dart';
import 'package:uchochik/data/local/datasources/network_group_datasource.dart';
import 'package:uchochik/data/local/datasources/operation_log_datasource.dart';
import 'package:uchochik/data/local/isar_service.dart';
import 'package:uchochik/data/repositories/concentrator_repository_impl.dart';
import 'package:uchochik/data/repositories/meter_repository_impl.dart';
import 'package:uchochik/data/repositories/network_group_repository_impl.dart';
import 'package:uchochik/data/repositories/operation_log_repository_impl.dart';
import 'package:uchochik/domain/repositories/i_concentrator_repository.dart';
import 'package:uchochik/domain/repositories/i_meter_repository.dart';
import 'package:uchochik/domain/repositories/i_network_group_repository.dart';
import 'package:uchochik/domain/repositories/i_operation_log_repository.dart';
import 'package:uchochik/features/connection/bloc/connection_bloc.dart';
import 'package:uchochik/features/network_tree/bloc/network_tree_bloc.dart';
import 'package:uchochik/features/usb_detection/cubit/usb_detection_cubit.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  final isar = IsarService.instance.isar;

  // ── Datasources ───────────────────────────────────────────────────────────
  getIt.registerSingleton(NetworkGroupDatasource(isar));
  getIt.registerSingleton(ConcentratorDatasource(isar));
  getIt.registerSingleton(MeterDatasource(isar));
  getIt.registerSingleton(OperationLogDatasource(isar));

  // ── Repositories ──────────────────────────────────────────────────────────
  getIt.registerSingleton<INetworkGroupRepository>(
    NetworkGroupRepositoryImpl(getIt<NetworkGroupDatasource>()),
  );
  getIt.registerSingleton<IConcentratorRepository>(
    ConcentratorRepositoryImpl(getIt<ConcentratorDatasource>()),
  );
  getIt.registerSingleton<IMeterRepository>(
    MeterRepositoryImpl(getIt<MeterDatasource>()),
  );
  getIt.registerSingleton<IOperationLogRepository>(
    OperationLogRepositoryImpl(getIt<OperationLogDatasource>()),
  );

  // ── BLoCs ─────────────────────────────────────────────────────────────────
  // Singleton: connection state persists across screens
  getIt.registerSingleton(ConnectionBloc());

  // Singleton: USB attach/detach listening starts at app launch
  getIt.registerSingleton(UsbDetectionCubit());

  getIt.registerFactory(
    () => NetworkTreeBloc(
      concentratorRepository: getIt<IConcentratorRepository>(),
      meterRepository: getIt<IMeterRepository>(),
      groupRepository: getIt<INetworkGroupRepository>(),
    ),
  );
}
