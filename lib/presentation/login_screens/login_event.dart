part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {
  const LoginEvent();
}
class UpdateEmail extends LoginEvent {}
class UpdatePassword extends LoginEvent {}
class ChangePasswordVisibilityEvent extends LoginEvent {}
class LogInUserEvent extends LoginEvent {}
