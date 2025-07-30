import 'dart:async';
import 'dart:developer';
import 'package:wallet/wallet.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3dart/web3dart.dart';

import 'result.dart';
import 'storages.dart';

class Callbacks {
  static Future<Result<T>> executeWithTryCatch<T>({
    required Future<T> Function() operation,
  }) async {
    try {
      final result = await operation();
      return Result.ok(result);
    } on UserCancelledException catch (e) {
      throw AppException(e.toString());
    } on UnKnownException catch (e) {
      throw AppException(e.toString());
    } on AppException catch (e) {
      log(e.message, name: 'AppException');
      return Result.error(e);
    } on Exception catch (e) {
      log(e.toString(), name: 'Exception');
      return Result.error(e);
    }
  }

  static Future<Result<T>> executeBlockchain<T>({
    required Future<T> Function(
      EthPrivateKey credentials,
      EthereumAddress address,
    )
    operation,
  }) async {
    return executeWithTryCatch(
      operation: () async {
        final privKey = await SecureStorage.accountPrivKey;
        if (privKey == null) throw const AppException('Account not found');

        final credentials = EthPrivateKey.fromHex(privKey);
        final address = credentials.address;

        final result = operation(credentials, address);
        return result;
      },
    );
  }
}
