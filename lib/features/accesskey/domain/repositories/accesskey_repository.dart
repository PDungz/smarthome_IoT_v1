import '../entities/accesskey.dart';

abstract class AccessKeyRepository {
  Future<List<AccessKey>?> getAccessKeys();
  Future<bool> postAccessKey();
}
