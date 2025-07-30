import 'package:flutter/services.dart';
import 'package:wallet/wallet.dart';
import 'package:web3auth_flutter/input.dart';
import 'package:web3dart/web3dart.dart';

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

  static const String mockUsdcAddress =
      '0x946cE267a0F6045C994Fa6401aD2F5b8B2A51097';
  static const String mockAaveAddress =
      '0xfA1c92F494A701F7eA99fb3a6Fd10B198dA75bFD';
  static const String gathrfiAddress =
      '0x37c5cC6807f554Ad17F7b70e1bBF80905A8C9afE';

  static Future<DeployedContract> get mockUsdcContract async {
    final path = Assets.abis.mockUsdcAbi;
    final abiJson = await rootBundle.loadString(path);

    return DeployedContract(
      ContractAbi.fromJson(abiJson, 'MockUSDC'),
      EthereumAddress.fromHex(mockUsdcAddress),
    );
  }

  static Future<DeployedContract> get mockAaveContract async {
    final path = Assets.abis.mockAaveAbi;
    final abiJson = await rootBundle.loadString(path);

    return DeployedContract(
      ContractAbi.fromJson(abiJson, 'MockAavePool'),
      EthereumAddress.fromHex(mockAaveAddress),
    );
  }

  static Future<DeployedContract> get gathrfiContract async {
    final path = Assets.abis.gathrfiAbi;
    final abiJson = await rootBundle.loadString(path);

    return DeployedContract(
      ContractAbi.fromJson(abiJson, 'GathrFi'),
      EthereumAddress.fromHex(gathrfiAddress),
    );
  }
}
