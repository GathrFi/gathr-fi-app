import 'package:freezed_annotation/freezed_annotation.dart';

part 'web3_network.freezed.dart';
part 'web3_network.g.dart';

@freezed
abstract class Web3Network with _$Web3Network {
  const Web3Network._();
  factory Web3Network({
    required String name,
    required String rpcEndpoint,
    required int chainId,
    required String currencySymbol,
    required String blockExplorer,
    String? logo,
  }) = _Web3Network;

  factory Web3Network.fromJson(Map<String, dynamic> json) =>
      _$Web3NetworkFromJson(json);
}
