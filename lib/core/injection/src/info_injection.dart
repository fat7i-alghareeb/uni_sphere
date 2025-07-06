import 'package:dio/dio.dart';

import '../../../shared/remote/info_remote.dart';
import '../../../shared/repo/info_repo.dart';
import '../../../shared/states/bloc/info_bloc.dart';
import '../injection.dart' show getIt;

Future<void> infoInjection() async {
  getIt.registerSingleton<InfoRemote>(InfoRemote(
    getIt<Dio>(),
  ));
  getIt.registerSingleton<InfoRepo>(InfoRepo(
    infoRemote: getIt<InfoRemote>(),
  ));

  getIt.registerSingleton<InfoBloc>(InfoBloc(
    infoRepo: getIt<InfoRepo>(),
  ));
}
