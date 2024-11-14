// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../domain/entities/accesskey.dart';
import '../../domain/repositories/accesskey_repository.dart';
import '../datasource/accesskey_remote_datasource.dart';

class AccessKeyRepositoryImpl implements AccessKeyRepository {
  final AccessKeyRemoteDatasource remoteDatasource;

  AccessKeyRepositoryImpl({
    required this.remoteDatasource,
  });

  @override
  Future<List<AccessKey>?> getAccessKeys() async {
    return await remoteDatasource.getAccessKeys();
  }

  @override
  Future<bool> postAccessKey() async {
    return await remoteDatasource.postAccessKey();
  }
}
