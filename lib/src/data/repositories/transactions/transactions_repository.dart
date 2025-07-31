import 'package:injectable/injectable.dart';
import 'package:web3dart/web3dart.dart';

import '../../../shared/utils/callbacks.dart';
import '../../../shared/utils/result.dart';
import '../../services/web3/web3_service.dart';

part 'transactions_repository_impl.dart';

abstract class TransactionsRepository {
  Future<Result<String>> deposit(double amount);
  Future<Result<String>> withdraw(double amount);
}
