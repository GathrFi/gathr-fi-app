import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:wallet/wallet.dart';
import 'package:web3auth_flutter/output.dart';

import '../../../data/repositories/auth/auth_repository.dart';
import '../../../shared/utils/result.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository repository;
  ProfileBloc(this.repository) : super(const _Initial()) {
    on<_Load>((event, emit) async {
      emit(const _Loading());

      TorusUserInfo? userInfo;
      String? userAddress;
      EtherAmount? userBalance;

      final userInfoResult = await repository.getUserInfo();
      final userAddressResult = await repository.getUserAddress();
      final userBalanceResult = await repository.getUserBalance();

      switch (userInfoResult) {
        case Ok<TorusUserInfo>():
          userInfo = userInfoResult.value;
        case Error<TorusUserInfo>():
          emit(_Error(e: userInfoResult.error));
      }

      switch (userAddressResult) {
        case Ok<String>():
          userAddress = userAddressResult.value;
        case Error<String>():
          emit(_Error(e: userAddressResult.error));
      }

      switch (userBalanceResult) {
        case Ok<EtherAmount>():
          userBalance = userBalanceResult.value;
        case Error<EtherAmount>():
          emit(_Error(e: userBalanceResult.error));
      }

      emit(
        _Loaded(
          userInfo: userInfo,
          userAddress: userAddress,
          userBalance: userBalance,
        ),
      );
    });
  }
}
