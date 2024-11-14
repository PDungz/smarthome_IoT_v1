// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:smarthome_iot/features/profile/data/datasources/account_firestore_datasource.dart';
import 'package:smarthome_iot/features/profile/data/models/account_model.dart';
import 'package:smarthome_iot/features/profile/domain/entities/account_entity.dart';
import 'package:smarthome_iot/features/profile/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountFirestoreDatasource accountFirestoreDatasource;

  AccountRepositoryImpl({
    required this.accountFirestoreDatasource,
  });

  @override
  Future<void> createOrUpdateAccountData(
      String userId, AccountEntity accountDataEntity) {
    return accountFirestoreDatasource.createOrUpdateAccountData(
        userId,
        AccountModel(
          avatarUrl: accountDataEntity.avatarUrl,
          fullName: accountDataEntity.fullName,
          phoneNumber: accountDataEntity.phoneNumber,
          password: accountDataEntity.password,
        ));
  }

  @override
  Future<AccountEntity?> getAccountData(String userId) {
    return accountFirestoreDatasource.getAccountData(userId);
  }
}
