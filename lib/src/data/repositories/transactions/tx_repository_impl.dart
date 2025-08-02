part of 'tx_repository.dart';

@LazySingleton(as: TxRepository)
class TxRepositoryImpl implements TxRepository {
  TxRepositoryImpl(this.web3client);
  final Web3Client web3client;

  @override
  Future<Result<String>> send({
    required String recipient,
    required double amount,
  }) {
    return Callbacks.executeBlockchain<String>(
      operation: (credentials, address) async {
        final mockUsdcContract = await Web3Service.mockUsdcContract;
        final txTransfer = await web3client.sendTransaction(
          credentials,
          chainId: int.tryParse(Web3Service.chainConfig.chainId),
          Transaction.callContract(
            contract: mockUsdcContract,
            function: mockUsdcContract.function('transfer'),
            parameters: [
              EthereumAddress.fromHex(recipient),
              amount.toRawToken(),
            ],
          ),
        );

        await Web3Service.waitForTxReceipt(txTransfer);
        return txTransfer;
      },
    );
  }
}
