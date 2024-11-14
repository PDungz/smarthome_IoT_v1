abstract class TokenRepository {
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
  Future<DateTime?> getTokenExpiryTime();
  Future<void> saveToken(
      String accessToken, String refreshToken, int expiresIn);
  Future<void> clearTokens();
}
