part of 'transactions_repository.dart';

@LazySingleton(as: TransactionsRepository)
class TransactionsRepositoryImpl implements TransactionsRepository {
  TransactionsRepositoryImpl(this.web3client);
  final Web3Client web3client;

  Future<bool> _approve(BigInt rawAmount) async {
    final result = await Callbacks.executeBlockchain<bool>(
      operation: (credentials, address) async {
        final mockUsdcContract = await Web3Service.mockUsdcContract;
        final txApprove = await web3client.sendTransaction(
          credentials,
          chainId: int.tryParse(Web3Service.chainConfig.chainId),
          Transaction.callContract(
            contract: mockUsdcContract,
            function: mockUsdcContract.function('approve'),
            parameters: [Web3Service.gathrfiAddress, rawAmount],
          ),
        );

        final txReceipt = await Web3Service.waitForTxReceipt(txApprove);
        return txReceipt != null;
      },
    );

    return switch (result) {
      Ok<bool>() => result.value,
      Error<bool>() => false,
    };
  }

  Future<bool> _checkAllowance(BigInt rawAmount) async {
    final result = await Callbacks.executeBlockchain<bool>(
      operation: (credentials, address) async {
        const timeout = Duration(seconds: 30);
        const retryDelay = Duration(seconds: 2);
        final startTime = DateTime.now();
        BigInt allowance;

        final mockUsdcContract = await Web3Service.mockUsdcContract;
        while (DateTime.now().difference(startTime) < timeout) {
          final allowanceResult = await web3client.call(
            contract: mockUsdcContract,
            function: mockUsdcContract.function('allowance'),
            params: [address, Web3Service.gathrfiAddress],
          );

          allowance = allowanceResult[0] as BigInt;
          if (allowance >= rawAmount) return true;

          await Future.delayed(retryDelay);
        }

        return false;
      },
    );

    return switch (result) {
      Ok<bool>() => result.value,
      Error<bool>() => false,
    };
  }

  @override
  Future<Result<String>> deposit(double amount) {
    return Callbacks.executeBlockchain<String>(
      operation: (credentials, address) async {
        final rawAmount = amount.toRawToken();

        final isApproved = await _approve(rawAmount);
        if (!isApproved) throw Exception('Transaction was not approved.');

        final isAllowanceSufficient = await _checkAllowance(rawAmount);
        if (!isAllowanceSufficient) throw Exception('Insufficient allowance');

        final gathrfiContract = await Web3Service.gathrfiContract;
        final txDepositFunds = await web3client.sendTransaction(
          credentials,
          chainId: int.tryParse(Web3Service.chainConfig.chainId),
          Transaction.callContract(
            contract: gathrfiContract,
            function: gathrfiContract.function('depositFunds'),
            parameters: [rawAmount],
          ),
        );

        await Web3Service.waitForTxReceipt(txDepositFunds);
        return txDepositFunds;
      },
    );
  }

  @override
  Future<Result<String>> withdraw(double amount) {
    return Callbacks.executeBlockchain<String>(
      operation: (credentials, address) async {
        final rawAmount = amount.toRawToken();

        final gathrfiContract = await Web3Service.gathrfiContract;
        final txWithdrawFunds = await web3client.sendTransaction(
          credentials,
          chainId: int.tryParse(Web3Service.chainConfig.chainId),
          Transaction.callContract(
            contract: gathrfiContract,
            function: gathrfiContract.function('withdrawFunds'),
            parameters: [rawAmount],
          ),
        );

        await Web3Service.waitForTxReceipt(txWithdrawFunds);
        return txWithdrawFunds;
      },
    );
  }
}
