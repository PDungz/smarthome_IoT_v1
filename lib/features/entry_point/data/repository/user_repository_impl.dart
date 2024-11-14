// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../data_source/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImpl({
    required this.userRemoteDataSource,
  });

  @override
  Future<User?> getUser() async {
    return await userRemoteDataSource.getUser();
  }

  @override
  Future<bool> putUser(User user, String password) async {
    return await userRemoteDataSource.putUser(user, password);
  }
}
