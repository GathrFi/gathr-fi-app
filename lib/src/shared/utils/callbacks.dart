import 'dart:async';
import 'dart:developer';
import 'package:web3auth_flutter/input.dart';

import 'result.dart';

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
}
