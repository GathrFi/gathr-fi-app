import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../gathrfi_app_di.dart';

class SecureStorage {
  static const String _accountPrivKey = 'gathrfi-account-priv-key';

  static Future<void> storeAccountPrivKey(String value) {
    return locator<FlutterSecureStorage>().write(
      key: _accountPrivKey,
      value: value,
    );
  }

  static Future<void> clearAccountPrivKey() {
    return locator<FlutterSecureStorage>().delete(key: _accountPrivKey);
  }

  static Future<String?> get accountPrivKey {
    return locator<FlutterSecureStorage>().read(key: _accountPrivKey);
  }
}
