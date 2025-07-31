import 'package:flutter/services.dart';
import 'package:wallet/wallet.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3dart/web3dart.dart';

import '../../../gathrfi_app_di.dart';
import '../../../shared/assets/assets.gen.dart';

class Web3Service {
  static ChainConfig get chainConfig {
    return ChainConfig(
      chainId: 4202.toString(),
      rpcTarget: 'https://rpc.sepolia-api.lisk.com',
      blockExplorerUrl: 'https://sepolia-blockscout.lisk.com',
      logo: 'https://lisk.com/wp-content/uploads/2025/02/Logo-mark.svg',
      displayName: 'Lisk Sepolia Testnet',
      tickerName: 'Lisk Sepolia Testnet',
      ticker: 'ETH',
    );
  }

  static EthereumAddress get mockUsdcAddress =>
      EthereumAddress.fromHex('0x946cE267a0F6045C994Fa6401aD2F5b8B2A51097');
  static EthereumAddress get mockAaveAddress =>
      EthereumAddress.fromHex('0xfA1c92F494A701F7eA99fb3a6Fd10B198dA75bFD');
  static EthereumAddress get gathrfiAddress =>
      EthereumAddress.fromHex('0x37c5cC6807f554Ad17F7b70e1bBF80905A8C9afE');

  static Future<DeployedContract> get mockUsdcContract async {
    final abiJson = await rootBundle.loadString(Assets.abis.mockUsdcAbi);

    return DeployedContract(
      ContractAbi.fromJson(abiJson, 'MockUSDC'),
      mockUsdcAddress,
    );
  }

  static Future<DeployedContract> get mockAaveContract async {
    final abiJson = await rootBundle.loadString(Assets.abis.mockAaveAbi);

    return DeployedContract(
      ContractAbi.fromJson(abiJson, 'MockAavePool'),
      mockAaveAddress,
    );
  }

  static Future<DeployedContract> get gathrfiContract async {
    final abiJson = await rootBundle.loadString(Assets.abis.gathrfiAbi);

    return DeployedContract(
      ContractAbi.fromJson(abiJson, 'GathrFi'),
      gathrfiAddress,
    );
  }

  static Future<TransactionReceipt?> waitForTxReceipt(String txHash) async {
    final client = locator<Web3Client>();

    while (true) {
      final receipt = await client.getTransactionReceipt(txHash);
      if (receipt != null) return receipt;

      await Future.delayed(const Duration(seconds: 1));
    }
  }
}

extension TokenConverter on BigInt {
  /// Converts a raw BigInt value (smallest unit) to a human-readable double.
  /// [decimals] specifies the number of decimal places
  /// (default: 6 for USDC-like tokens).
  double toTokenAmount({int decimals = 6}) {
    return toDouble() / BigInt.from(10).pow(decimals).toDouble();
  }
}

extension TokenRawConverter on double {
  /// Converts a human-readable double to a raw BigInt value (smallest unit).
  /// [decimals] specifies the number of decimal places
  /// (default: 6 for USDC-like tokens).
  BigInt toRawToken({int decimals = 6}) {
    return (this * BigInt.from(10).pow(decimals).toDouble()).toBigInt();
  }
}

// Extension to convert double to BigInt safely
extension _DoubleToBigInt on double {
  BigInt toBigInt() => BigInt.from(this);
}
