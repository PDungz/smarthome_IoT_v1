// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:smarthome_iot/core/common/global_setting/domain/repositories/global_repository.dart';

class GlobalInfoUsecases {
  final GlobalRepository globalRepository;

  GlobalInfoUsecases({
    required this.globalRepository,
  });

  Future<Locale?> getLocale() {
    return globalRepository.getLocale();
  }

  Future<bool> setSaveLangCode(String LangCode) {
    return globalRepository.setSaveLangCode(LangCode);
  }
}
