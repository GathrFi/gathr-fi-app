import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repositories/auth/auth_repository.dart';
import '../../../shared/utils/result.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc(this.repository) : super(const _Initial()) {
    on<_Initialize>((event, emit) async {
      emit(const _Loading());
      final result = await repository.initialize();

      switch (result) {
        case Ok<bool>():
          if (result.value) {
            emit(const _Authenticated());
          } else {
            emit(const _Unauthenticated());
          }
        case Error<bool>():
          emit(_Error(result.error));
      }
    });

    on<_LoginWithEmail>((event, emit) async {
      emit(const _Loading());
      final result = await repository.loginWithEmail(event.email);

      switch (result) {
        case Ok<bool>():
          emit(const _Authenticated());
        case Error<bool>():
          emit(_Error(result.error));
      }
    });

    on<_LoginWithGoogle>((event, emit) async {
      emit(const _Loading());
      final result = await repository.loginWithGoogle();

      switch (result) {
        case Ok<bool>():
          emit(const _Authenticated());
        case Error<bool>():
          emit(_Error(result.error));
      }
    });

    on<_LoginWithApple>((event, emit) async {
      emit(const _Loading());
      final result = await repository.loginWithApple();

      switch (result) {
        case Ok<bool>():
          emit(const _Authenticated());
        case Error<bool>():
          emit(_Error(result.error));
      }
    });

    on<_LoginWithDiscord>((event, emit) async {
      emit(const _Loading());
      final result = await repository.loginWithDiscord();

      switch (result) {
        case Ok<bool>():
          emit(const _Authenticated());
        case Error<bool>():
          emit(_Error(result.error));
      }
    });

    on<_Logout>((event, emit) async {
      emit(const _Loading());
      final result = await repository.logout();

      switch (result) {
        case Ok<bool>():
          emit(const _Unauthenticated());
        case Error<bool>():
          emit(_Error(result.error));
      }
    });
  }
}
