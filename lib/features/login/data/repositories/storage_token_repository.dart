// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:smarthome_iot/features/login/domain/repositories/token_repository.dart';

class StorageTokenRepository implements TokenRepository {
  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenkey = 'refreshToken';
  static const _tokenExpiryKey = 'tokenExpiryTime';

  final FlutterSecureStorage secureStorage;

  StorageTokenRepository({
    required this.secureStorage,
  });

  @override
  Future<void> clearTokens() async {
    await secureStorage.delete(key: _accessTokenKey);
    await secureStorage.delete(key: _refreshTokenkey);
    await secureStorage.delete(key: _tokenExpiryKey);
  }

  @override
  Future<String?> getAccessToken() async {
    return await secureStorage.read(key: _accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await secureStorage.read(key: _refreshTokenkey);
  }

  @override
  Future<DateTime?> getTokenExpiryTime() async {
    String? expiryString = await secureStorage.read(key: _tokenExpiryKey);
    if (expiryString != null) {
      return DateTime.parse(expiryString);
    }
    return null;
  }

  @override
  Future<void> saveToken(
      String accessToken, String refreshToken, int expiresIn) async {
    final expiryTime =
        DateTime.now().add(Duration(seconds: expiresIn)).toIso8601String();
    await secureStorage.write(key: _accessTokenKey, value: accessToken);
    await secureStorage.write(key: _refreshTokenkey, value: refreshToken);
    await secureStorage.write(key: _tokenExpiryKey, value: expiryTime);
  }
}
