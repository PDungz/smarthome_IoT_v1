import 'package:flutter_dotenv/flutter_dotenv.dart';

class DotEnvUtil {
  static String get apiHost => dotenv.env['HOST_API'] ?? '';
  static String get apiVersion => dotenv.env['API_VERSION'] ?? '';
  static String get websocketVersion => dotenv.env['HOST_WEBSOCKET'] ?? '';
  static Future<void> initDotEnv() async {
    await dotenv.load(fileName: '.env');
  }
}
