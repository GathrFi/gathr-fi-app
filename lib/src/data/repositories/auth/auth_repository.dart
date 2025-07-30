import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:web3auth_flutter/enums.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3auth_flutter/output.dart';
import 'package:web3auth_flutter/web3auth_flutter.dart';
import 'package:web3dart/web3dart.dart';

import '../../../shared/utils/callbacks.dart';
import '../../../shared/utils/result.dart';
import '../../../shared/utils/storages.dart';

part 'auth_repository_impl.dart';

abstract class AuthRepository {
  Future<Result<bool>> initialize();
  Future<Result<bool>> loginWithEmail(String email);
  Future<Result<bool>> loginWithGoogle();
  Future<Result<bool>> loginWithApple();
  Future<Result<bool>> loginWithDiscord();
  Future<Result<bool>> logout();
}
