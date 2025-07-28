import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:r_r_t_app/presentation/home_screen/home_state.dart';
import 'package:r_r_t_app/repository/local_storage_repository.dart';


part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LocalStorageRepository _localStorageRepository;

  HomeBloc({required final localStorageRepository})
    : _localStorageRepository = localStorageRepository,

      super(HomeState.initial()) {
    on<ReadEmail>((event, emit) async {
      await _readUserEmail(emit);
    });
    on<RemoveToken>((event, emit) async {
      await _removeToken(emit);
    });
    add(ReadEmail());
  }

  Future<void> _readUserEmail(Emitter<HomeState> emit) async {
    try {
      final email = await _localStorageRepository.readEmail();
      if (email != null){
      emit(state.copyWith(email: email));
      } else {
        emit(state.copyWith(exception: Exception()));
      }
    } finally {

    }
  }

  Future<void> _removeToken(Emitter<HomeState> emit) async {
    try {
     await _localStorageRepository.removeToken().then((_){
       emit(state.copyWith(isUserDone: true));
     });
    } catch (ex) {
      emit(state.copyWith(exception: Exception(ex)));
    }
  }
}
