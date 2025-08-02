import 'package:injectable/injectable.dart';
import 'package:wallet/wallet.dart';
import 'package:web3dart/web3dart.dart';

import '../../../shared/utils/callbacks.dart';
import '../../../shared/utils/result.dart';
import '../../services/web3/web3_service.dart';

part 'tx_repository_impl.dart';

abstract class TxRepository {
  Future<Result<String>> send({
    required String recipient,
    required double amount,
  });
}
