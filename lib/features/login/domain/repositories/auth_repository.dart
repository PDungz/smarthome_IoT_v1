abstract class AuthRepository {
  Future<bool> loginWithPhoneNumberPassword(
      {required String phoneNumber, required String password});
  Future<bool> logout();
}
