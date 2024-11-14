import 'package:flutter/material.dart';

abstract class GlobalRepository {
  Future<Locale?> getLocale();
  Future<bool> setSaveLangCode(String LangCode);
}
