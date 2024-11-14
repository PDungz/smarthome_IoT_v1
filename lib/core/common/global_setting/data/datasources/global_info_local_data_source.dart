// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shared_preferences/shared_preferences.dart';

abstract class GlobalInfoLocalDataSource {
  Future<String?> getLocale();
  Future<bool> setSavedLangCode(String langCode);
}

class GlobalInfoLocalDataSourceImpl implements GlobalInfoLocalDataSource {
  final SharedPreferences sharedPreferences;

  GlobalInfoLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<String?> getLocale() async {
    return sharedPreferences.getString('SAVED_LANGUAGE');
  }

  @override
  Future<bool> setSavedLangCode(String langCode) async {
    return sharedPreferences.setString('SAVED_LANGUAGE', langCode);
  }
}
