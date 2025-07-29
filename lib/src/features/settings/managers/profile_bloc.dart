import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:wallet/wallet.dart';
import 'package:web3auth_flutter/output.dart';

import '../../../data/models/user/user_profile.dart';
import '../../../data/repositories/auth/auth_repository.dart';
import '../../../data/repositories/user/user_profile_repository.dart';
import '../../../shared/utils/result.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository authRepository;
  final UserProfileRepository profileRepository;
  ProfileBloc(this.authRepository, this.profileRepository)
    : super(const _Initial()) {
    on<_Load>((event, emit) async {
      emit(const _Loading());

      TorusUserInfo? userInfo;
      String? userAddress;
      EtherAmount? userBalance;

      final userInfoResult = await authRepository.getUserInfo();
      final userAddressResult = await authRepository.getUserAddress();
      final userBalanceResult = await authRepository.getUserBalance();

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

      UserProfile? userProfile;
      if (userAddress != null) {
        final userProfileResult = await profileRepository.get(userAddress);
        if (userProfileResult is Ok<UserProfile>) {
          userProfile = userProfileResult.value;
        }
      }

      emit(
        _Loaded(
          userInfo: userInfo,
          userAddress: userAddress,
          userBalance: userBalance,
          userProfile: userProfile,
        ),
      );
    });

    on<_Update>((event, emit) async {
      emit(const _Loading());
      final result = await profileRepository.update(event.userProfile);

      switch (result) {
        case Ok<bool>():
          add(const _Load());
        case Error<bool>():
          emit(_Error(e: result.error));
      }
    });
  }
}
