import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smarthome_iot/core/constants/colors/app_colors.dart';
import 'package:smarthome_iot/core/services/injection_container.dart';
import 'package:smarthome_iot/features/accesskey/presentation/view_accesskey_routes.dart';
import 'package:smarthome_iot/features/add/presentation/add_routes.dart';
import 'package:smarthome_iot/features/device/presentation/add_device_routes.dart';
import 'package:smarthome_iot/features/device/presentation/update_device_routes.dart';
import 'package:smarthome_iot/features/device/presentation/view_device_routes.dart';
import 'package:smarthome_iot/features/entry_point/presentation/view/app_bottom_navigation_bar.dart';
import 'package:smarthome_iot/features/entry_point/presentation/view/header_session.dart';
import 'package:smarthome_iot/features/entry_point/presentation/view/header_sessionn_loading.dart';
import 'package:smarthome_iot/features/home/presentation/home_routes.dart';
import 'package:smarthome_iot/features/notification/presentation/notification_routes.dart';
import 'package:smarthome_iot/features/room/presentation/add_room_routes.dart';
import 'package:smarthome_iot/features/room/presentation/update_room_routes.dart';
import 'package:smarthome_iot/features/room/presentation/view_room_routes.dart';
import 'package:smarthome_iot/features/setting/presentation/logic_holder/user_bloc/user_bloc.dart';
// import '../../../core/services/websocket_service.dart';
import '../../../core/utils/format_date_util.dart';
import '../data/repository/user_repository_impl.dart';

class EntryPoint extends StatefulWidget {
  final int? initialIndex;
  final String? id;
  const EntryPoint({
    super.key,
    this.initialIndex = 0,
    this.id,
  });

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  // final webSocketService = WebSocketService();
  int _currentIndex = 0;

  // Danh sách các trang
  List<Widget> get pages => [
        const HomeRoutes(),
        const AddRoutes(),
        const NotificationRoutes(),
        // Room
        const ViewRoomRoutes(),
        const AddRoomRoutes(),
        UpdateRoomRoutes(
          roomId: widget.id,
        ),
        // Device
        const ViewDeviceRoutes(),
        const AddDeviceRoutes(),
        UpdateDeviceRoutes(deviceId: widget.id),

        // AccessKey
        const ViewAccesskeyRoutes(),
      ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex!; // Khởi tạo biến với giá trị ban đầu
  }

  void onBottomNavigationTap(int index) {
    setState(() {
      _currentIndex = index; // Cập nhật giá trị biến riêng
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) =>
          UserBloc(UserRepositoryImpl(userRemoteDataSource: getIt()))
            ..add(LoadUser()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: BlocBuilder<UserBloc, UserState>(
                    builder: (context, state) {
                      if (state is UserLoading) {
                        return const HeaderSessionnLoading();
                      } else if (state is UserLoaded) {
                        // webSocketService.connect(state.user.id);
                        final String fullName = state.user.fullName;
                        final String toDayTime =
                            DateUtil.formatFullDate(DateTime.now());
                        return HeaderSession(
                          userId: state.user.id,
                          fullName: fullName,
                          toDayTime: toDayTime,
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      // Page transition
                      Positioned.fill(
                        child: PageTransitionSwitcher(
                          transitionBuilder:
                              (child, primaryAnimation, secondaryAnimation) {
                            return SharedAxisTransition(
                              animation: primaryAnimation,
                              secondaryAnimation: secondaryAnimation,
                              transitionType:
                                  SharedAxisTransitionType.horizontal,
                              fillColor: AppColors.primaryColor,
                              child: child,
                            );
                          },
                          child:
                              pages[_currentIndex], // Use the private variable
                        ),
                      ),
                      // Bottom navigation bar
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: AppNavigationBar(
                          currentIndex: _currentIndex,
                          onNavTap: onBottomNavigationTap,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
