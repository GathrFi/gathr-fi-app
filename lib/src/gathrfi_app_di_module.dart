import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:web3dart/web3dart.dart';

import 'data/services/api/graphql_service.dart';
import 'data/services/web3/web3_service.dart';

@module
abstract class GathrfiAppDiModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  SupabaseClient get supabaseClient => Supabase.instance.client;

  @lazySingleton
  Client get httpClient => Client();

  @lazySingleton
  Web3Client get web3Client {
    return Web3Client(Web3Service.chainConfig.rpcTarget, httpClient);
  }

  @lazySingleton
  GraphQLClient get graphQLClient {
    const url = String.fromEnvironment('GRAPHQL_API_URL', defaultValue: '');
    return GraphQLClient(
      link: HttpLink(url),
      cache: GraphQLCache(store: HiveStore()),
    );
  }

  @lazySingleton
  GraphQLService get graphQLService => GraphQLService(graphQLClient);
}
