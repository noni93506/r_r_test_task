import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:r_r_t_app/presentation/login_screens/login_state.dart';
import 'package:r_r_t_app/repository/local_storage_repository.dart';
import 'package:r_r_t_app/repository/login_repository.dart';
import 'package:r_r_t_app/validators/email_validator.dart';
import 'package:r_r_t_app/validators/password_validator.dart';

part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final EmailValidator _emailValidator;
  final PasswordValidator _passwordValidator;
  final LoginRepository _loginRepository;
  final LocalStorageRepository _localStorageRepository;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginBloc({
    required final emailValidator,
    required final passwordValidator,
    required final loginRepository,
    required final localStorageRepository,
  }) : _emailValidator = emailValidator,
       _passwordValidator = passwordValidator,
       _localStorageRepository = localStorageRepository,
       _loginRepository = loginRepository,
       super(LoginState.initial()) {
    on<ChangePasswordVisibilityEvent>((event, emit) {
      _changePasswordVisibility(emit);
    });
    on<LogInUserEvent>((event, emit) async {
      await _loginUser(emit);
    });
    on<UpdateEmail>((event, emit) {
      _updateEmail(emit);
    });
    on<UpdatePassword>((event, emit) {
      _updatePassword(emit);
    });
    emailController.addListener(() {
      add(UpdateEmail());
    });
    passwordController.addListener(() {
      add(UpdatePassword());
    });
  }

  void _updateEmail(Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        email: emailController.text,
        isEmailValid: _emailValidator.validate(email: state.email),
      ),
    );
  }

  void _changePasswordVisibility(Emitter<LoginState> emit) {
    emit(state.copyWith(isPasswordObscureText: !state.isPasswordObscureText));
  }

  void _updatePassword(Emitter<LoginState> emit) {
    emit(
      state.copyWith(
        password: passwordController.text,
        isPasswordValid: _passwordValidator.validate(password: state.password),
      ),
    );
  }

  bool _validateFields(Emitter<LoginState> emit) {
    final emailValid = _emailValidator.validate(email: state.email);
    final passwordValid = _passwordValidator.validate(password: state.password);
    emit(
      state.copyWith(isEmailValid: emailValid, isPasswordValid: passwordValid),
    );
    return emailValid && passwordValid == true;
  }

  Future<void> _loginUser(Emitter<LoginState> emit) async {
    if (!_validateFields(emit)) {
      emit(state.copyWith(showSnackBar: true));
      emit(state.copyWith(showSnackBar: false));
      return;
    }

    emit(state.copyWith(isLoading: true));
    try {
      final token = await _loginRepository.loginUser(
        email: state.email,
        password: state.password,
      );

        await _localStorageRepository.saveToken(
          token: token,
          email: state.email,
        );
      emit(state.copyWith(isLogInComplete: true, isLoading: false));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }
}
