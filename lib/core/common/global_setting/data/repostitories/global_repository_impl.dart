// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:smarthome_iot/core/common/global_setting/data/datasources/global_info_local_data_source.dart';
import 'package:smarthome_iot/core/common/global_setting/domain/repositories/global_repository.dart';

class GlobalRepositoryImpl implements GlobalRepository {
  final GlobalInfoLocalDataSource globalInfoLocalDataSource;
  GlobalRepositoryImpl({
    required this.globalInfoLocalDataSource,
  });

  @override
  Future<Locale?> getLocale() async {
    final langCode = await globalInfoLocalDataSource.getLocale();
    if (langCode != null) {
      return Locale(langCode);
    }
    return null;
  }

  @override
  Future<bool> setSaveLangCode(String LangCode) {
    return globalInfoLocalDataSource.setSavedLangCode(LangCode);
  }
}
