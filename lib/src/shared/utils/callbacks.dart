import 'dart:async';
import 'dart:developer';
import 'result.dart';

class Callbacks {
  static Future<Result<T>> executeWithTryCatch<T>({
    required Future<T> Function() operation,
  }) async {
    try {
      final result = await operation();
      return Result.ok(result);
    } on AppException catch (e) {
      log(e.message, name: 'AppException');
      return Result.error(e);
    } on Exception catch (e) {
      log(e.toString(), name: 'Exception');
      return Result.error(e);
    }
  }
}
