part of 'home_bloc.dart';

class HomeState {
  Result<HomeEntity> result;

  HomeState({
    this.result = const Result.init(),
  });

  HomeState copyWith({
    Result<HomeEntity>? result,
  }) {
    return HomeState(
      result: result ?? this.result,
    );
  }
}
