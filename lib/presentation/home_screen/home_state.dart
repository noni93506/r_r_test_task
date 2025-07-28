import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const HomeState._();

  const factory HomeState({
    required String email,
    required Exception? exception,
    required bool isLoading,
    required bool isUserDone,
  }) = _HomeState;

  factory HomeState.initial() {
    return const HomeState(
      email: '',
      exception: null,
      isLoading: false,
      isUserDone: false,
    );
  }
}
