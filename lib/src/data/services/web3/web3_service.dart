import '../../models/web3/web3_network.dart';

class Web3Service {
  static Web3Network get network {
    return Web3Network(
      name: 'Lisk Sepolia Testnet',
      rpcEndpoint: 'https://rpc.sepolia-api.lisk.com',
      chainId: 4202,
      currencySymbol: 'ETH',
      blockExplorer: 'https://sepolia-blockscout.lisk.com',
      logo: 'https://lisk.com/wp-content/uploads/2025/02/Logo-mark.svg',
    );
  }
}
