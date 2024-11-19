import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smarthome_iot/core/common/global_setting/presentation/global_info_bloc/global_info_bloc.dart';
import 'package:smarthome_iot/firebase_options.dart';
import 'package:smarthome_iot/l10n/generated/app_localizations.dart';
import 'core/constants/components/components_notification/notification_controller.dart';
import 'core/routes/app_generate_routes.dart';
import 'core/routes/app_routes.dart';
import 'core/services/injection_container.dart';
import 'core/themes/app_theme_data.dart';
import 'core/utils/dot_env_util.dart';
import 'core/services/injection_container.dart' as di;
import 'features/login/domain/repositories/token_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Awesome Notifications
  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
        channelGroupKey: 'basic_channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic notification',
        channelDescription: 'Basic notification channel',
        defaultColor: Colors.blue,
        ledColor: Colors.white,
        importance: NotificationImportance.High,
        playSound: true,
        soundSource: 'resource://raw/attack', // Âm thanh tùy chỉnh
      ),
    ],
    channelGroups: [
      NotificationChannelGroup(
        channelGroupKey: 'basic_channel_group',
        channelGroupName: 'Basic Group',
      ),
    ],
  );

  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();

  if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  // Yêu cầu quyền ghi âm
  await requestMicrophonePermission();

  // Khởi tạo Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Khởi tạo các cấu hình khác
  await DotEnvUtil.initDotEnv();
  await di.init();

  final tokenRepository = di.getIt<TokenRepository>();

  DateTime? tokenExpiryTime = await tokenRepository.getTokenExpiryTime();
  bool isTokenValidExpired =
      tokenExpiryTime != null && tokenExpiryTime.isAfter(DateTime.now());
  String? accessToken = await tokenRepository.getAccessToken();

  String initialRoute = accessToken != null && isTokenValidExpired
      ? AppRoutes.entry_point
      : AppRoutes.login;

  runApp(MyApp(initialRoute: initialRoute));
}

// Hàm yêu cầu quyền ghi âm
Future<void> requestMicrophonePermission() async {
  PermissionStatus status = await Permission.microphone.request();

  if (status.isGranted) {
    print('Microphone permission granted');
  } else if (status.isDenied) {
    print('Microphone permission denied');
  } else if (status.isPermanentlyDenied) {
    openAppSettings();
  }
}

class MyApp extends StatefulWidget {
  final String initialRoute;

  const MyApp({
    super.key,
    required this.initialRoute,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GlobalInfoBloc>(
      create: (_) => GlobalInfoBloc(getIt())..add(GetGlobalInfo()),
      child: BlocBuilder<GlobalInfoBloc, GlobalInfoState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'SmartHome',
            theme: AppThemeData.defaultheme,
            locale: state.currentLocale,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode ==
                    deviceLocale?.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            onGenerateRoute: AppGenerateRoutes.onGenerate,
            initialRoute: widget.initialRoute, // Use the dynamic initial route
          );
        },
      ),
    );
  }
}
