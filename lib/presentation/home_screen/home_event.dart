part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {
  const HomeEvent();
}
class ReadEmail extends HomeEvent {}
class RemoveToken extends HomeEvent {}

