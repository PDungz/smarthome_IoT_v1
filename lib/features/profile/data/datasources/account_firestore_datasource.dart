import 'package:smarthome_iot/core/services/logger_service.dart';
import 'package:smarthome_iot/features/profile/data/models/account_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AccountFirestoreDatasource {
  Future<AccountModel?> getAccountData(String userId);
  Future<void> createOrUpdateAccountData(String userId, AccountModel account);
}

class AccountFirestoreDatasourceImpl implements AccountFirestoreDatasource {
  @override
  Future<AccountModel?> getAccountData(String userId) async {
    final db = FirebaseFirestore.instance;
    final accountRef = db.collection('accounts').doc(userId);
    final result = await accountRef.get();
    final data = result.data();
    if (result.exists && data != null) {
      return AccountModel.fromJson(data);
    } else {
      return null;
    }
  }

  @override
  Future<void> createOrUpdateAccountData(
      String userId, AccountModel account) async {
    final db = FirebaseFirestore.instance;
    DocumentReference userDocRef = db.collection('accounts').doc(userId);
    DocumentSnapshot docSnapshot = await userDocRef.get();
    if (docSnapshot.exists) {
      await userDocRef.update(account.toJsonNonNull());
      printS("Account Info updated");
    } else {
      await userDocRef.set(account.toJsonNonNull());
      printS("Account Info created!");
    }
  }
}
