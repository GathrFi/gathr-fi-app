part of 'auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this.web3client);
  final Web3Client web3client;

  @override
  Future<Result<bool>> initialize() {
    return Callbacks.executeWithTryCatch<bool>(
      operation: () async {
        Uri? redirectUrl;
        if (Platform.isAndroid) {
          redirectUrl = Uri.parse('w3a://com.rainfore.gathrfi');
        } else if (Platform.isIOS) {
          redirectUrl = Uri.parse('com.rainfore.gathrfi://auth');
        } else {
          throw UnKnownException('Unknown platform');
        }

        await Web3AuthFlutter.init(
          Web3AuthOptions(
            clientId: const String.fromEnvironment(
              'WEB3_AUTH_CLIENT_ID',
              defaultValue: '',
            ),
            network: Network.sapphire_devnet,
            redirectUrl: redirectUrl,
            buildEnv: BuildEnv.production,
          ),
        );

        await Web3AuthFlutter.initialize();
        final privKey = await Web3AuthFlutter.getPrivKey();
        return privKey.isNotEmpty;
      },
    );
  }

  Future<Result<bool>> _login(
    Future<Web3AuthResponse> Function() method,
  ) async {
    return Callbacks.executeWithTryCatch<bool>(
      operation: () async {
        final response = await method();

        final privKey = response.privKey;
        if (privKey != null) {
          await SecureStorage.storeAccountPrivKey(privKey);
        }

        return true;
      },
    );
  }

  @override
  Future<Result<bool>> loginWithEmail(String email) {
    return _login(() async {
      final response = await Web3AuthFlutter.login(
        LoginParams(
          loginProvider: Provider.email_passwordless,
          extraLoginOptions: ExtraLoginOptions(login_hint: email),
        ),
      );

      return response;
    });
  }

  @override
  Future<Result<bool>> loginWithGoogle() {
    return _login(() async {
      final response = await Web3AuthFlutter.login(
        LoginParams(loginProvider: Provider.google),
      );

      return response;
    });
  }

  @override
  Future<Result<bool>> loginWithApple() {
    return _login(() async {
      final response = await Web3AuthFlutter.login(
        LoginParams(loginProvider: Provider.apple),
      );

      return response;
    });
  }

  @override
  Future<Result<bool>> loginWithDiscord() {
    return _login(() async {
      final response = await Web3AuthFlutter.login(
        LoginParams(loginProvider: Provider.discord),
      );

      return response;
    });
  }

  @override
  Future<Result<bool>> logout() {
    return Callbacks.executeWithTryCatch<bool>(
      operation: () async {
        await Web3AuthFlutter.logout();
        await SecureStorage.clearAccountPrivKey();
        return true;
      },
    );
  }
}
