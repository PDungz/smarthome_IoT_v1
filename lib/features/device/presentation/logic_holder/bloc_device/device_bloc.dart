import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smarthome_iot/core/services/websocket_service.dart';
import 'package:smarthome_iot/features/device/domain/entities/device.dart';
import 'package:smarthome_iot/features/device/domain/repositories/device_repository.dart';
import 'package:smarthome_iot/features/room/domain/repositories/room_repository.dart';

import '../../../../../core/enums/status_state.dart';

part 'device_event.dart';
part 'device_state.dart';

class DeviceBloc extends Bloc<DeviceEvent, DeviceState> {
  final DeviceRepository deviceRepository;
  final RoomRepository roomRepository;
  final WebSocketService webSocketService;

  DeviceBloc(this.deviceRepository, this.webSocketService, this.roomRepository)
      : super(DeviceLoading()) {
    on<LoadDeviceByRoomId>(_onLoadDevicesByRoomId);
    on<LoadDeviceById>(_onLoadDeviceById);
    on<UpdateDevice>(_onUpdateDevice);
    on<LoadDevices>(_onLoadDevices);
    on<PostDevice>(_onPostDevice);
    on<PutDevice>(_onPutDevice);
    on<DeleteDevice>(_onDeleteDevice);
    on<UpdateDeviceWithVoice>(_onUpdateDeviceWithVoice);
  }

  Future<void> _onLoadDevices(
      LoadDevices event, Emitter<DeviceState> emit) async {
    emit(DeviceLoading());

    try {
      final devices = await deviceRepository.getDevices();
      emit(DevicesLoaded(devices: devices ?? []));
    } catch (e) {
      emit(DeviceError(message: e.toString()));
    }
  }

  Future<void> _onLoadDeviceById(
      LoadDeviceById event, Emitter<DeviceState> emit) async {
    emit(DeviceLoading());

    try {
      final device = await deviceRepository.getDeviceById(event.deviceId!);
      emit(DeviceLoaded(device: device!));
    } catch (e) {
      emit(DeviceError(message: e.toString()));
    }
  }

  Future<void> _onLoadDevicesByRoomId(
      LoadDeviceByRoomId event, Emitter<DeviceState> emit) async {
    emit(DeviceLoading());

    List<Device>? devices = []; // Khởi tạo biến devices ở đây

    try {
      if (event.roomId == "") {
        final rooms = await roomRepository.getRooms();
        if (rooms != null && rooms.isNotEmpty) {
          final roomId = rooms.first.id; // Lấy roomId từ phòng đầu tiên
          devices = await deviceRepository.getDevicesByRoomId(roomId);
        } else {
          emit(const DeviceError(
              message:
                  "No rooms available")); // Thông báo lỗi nếu không có phòng
          return; // Dừng xử lý nếu không có phòng
        }
      } else {
        devices = await deviceRepository.getDevicesByRoomId(event.roomId!);
      }
      emit(DevicesLoaded(devices: devices ?? []));
    } catch (e) {
      print("Error loading devices: $e"); // Log lỗi chi tiết
      emit(DeviceError(message: e.toString()));
    }
  }

  Future<void> _onUpdateDevice(
      UpdateDevice event, Emitter<DeviceState> emit) async {
    final currentState = state;

    emit(const DeviceUpdated(state: StatusState.loading));

    try {
      final success = await deviceRepository.putDevice(event.device);

      if (success) {
        if (currentState is DevicesLoaded) {
          // Cập nhật danh sách thiết bị hiện tại
          final updatedDevices = currentState.devices.map((device) {
            return device.id == event.device.id ? event.device : device;
          }).toList();
          webSocketService.updateDeviceState(
            event.device.type,
            event.device.state,
            event.device.gate,
            event.accessKey,
          ); // Truyền các tham số cần thiết
          emit(DevicesLoaded(devices: updatedDevices));
        }

        // Phát lại sự kiện LoadDevice để tải lại danh sách thiết bị
        add(LoadDeviceByRoomId(roomId: event.device.roomID));
        emit(const DeviceUpdated(
            state: StatusState.success, message: 'Cập nhật thành công'));
      } else {
        emit(const DeviceUpdated(
            state: StatusState.failure, message: 'Cập nhật thất bại'));
      }
    } catch (e) {
      emit(DeviceUpdated(state: StatusState.failure, message: e.toString()));
    }
  }

  Future<void> _onPostDevice(
      PostDevice event, Emitter<DeviceState> emit) async {
    try {
      final success = await deviceRepository.postDevice(event.device);
      if (success) {
        emit(const DevicePostSuccess(
            state: StatusState.success, message: "Device added successfully"));
      } else {
        emit(const DevicePostSuccess(
            state: StatusState.failure, message: "Failed to add device"));
      }
    } catch (e) {
      emit(DevicePostSuccess(
          state: StatusState.failure, message: "Error: ${e.toString()}"));
    }
  }

  Future<void> _onPutDevice(PutDevice event, Emitter<DeviceState> emit) async {
    try {
      final success = await deviceRepository.putDevice(event.device);
      if (success) {
        emit(const DevicePutSuccess(
            state: StatusState.success,
            message: "Device updated successfully"));
      } else {
        emit(const DevicePutSuccess(
            state: StatusState.failure, message: "Failed to update device"));
      }
    } catch (e) {
      emit(DevicePutSuccess(
          state: StatusState.failure, message: "Error: ${e.toString()}"));
    }
  }

  Future<void> _onDeleteDevice(
      DeleteDevice event, Emitter<DeviceState> emit) async {
    try {
      final success = await deviceRepository.deleteDevice(event.deviceId);
      if (success) {
        emit(const DeviceDeleted(
            state: StatusState.success,
            message: "Device deleted successfully"));
      } else {
        emit(const DeviceDeleted(
            state: StatusState.failure, message: "Failed to delete device"));
      }
    } catch (e) {
      emit(DeviceDeleted(
          state: StatusState.failure, message: "Error: ${e.toString()}"));
    }
  }

  Future<void> _onUpdateDeviceWithVoice(
      UpdateDeviceWithVoice event, Emitter<DeviceState> emit) async {
    emit(const DeviceUpdated(state: StatusState.loading));

    try {
      final devices = await deviceRepository.getDevices();
      if (devices == null || devices.isEmpty) {
        emit(const DeviceUpdated(
            state: StatusState.failure,
            message: 'Không tìm thấy thiết bị nào để tải dữ liệu'));
        return;
      }

      List<Device> devicesToUpdate = [];

      // Xác định các thiết bị cần cập nhật dựa trên giọng nói
      if (event.voice.contains('tất cả'.toUpperCase())) {
        // Bật/tắt tất cả các thiết bị
        devicesToUpdate = devices;
      } else if (event.voice.toUpperCase().contains('THIẾT BỊ PHÒNG')) {
        // Bật/tắt tất cả thiết bị trong phòng cụ thể
        for (var device in devices) {
          if (event.voice.contains(device.description.toUpperCase())) {
            devicesToUpdate.add(device);
          }
        }
      } else {
        // Bật/tắt thiết bị cụ thể
        for (var device in devices) {
          if ((event.voice.contains(device.name.toUpperCase()) &&
                  event.voice.contains(device.description.toUpperCase())) ||
              (event.voice.contains(device.name.toUpperCase()) &&
                  !event.voice.contains(device.description.toUpperCase()))) {
            devicesToUpdate.add(device);
          }
        }
      }

      // Xác định lệnh bật/tắt
      String action = '';
      if (event.voice.contains('bật'.toUpperCase()) ||
          event.voice.contains('mở'.toUpperCase())) {
        action = 'on';
      } else if (event.voice.contains('tắt'.toUpperCase()) ||
          event.voice.contains('đóng'.toUpperCase())) {
        action = 'off';
      }

      if (devicesToUpdate.isNotEmpty && action.isNotEmpty) {
        final updatedDevices = <Device>[];

        for (var device in devicesToUpdate) {
          final updatedDevice = device.copyWith(
            state: action == 'on' ? 'ON' : 'OFF',
          );

          final success = await deviceRepository.putDevice(updatedDevice);

          if (success) {
            updatedDevices.add(updatedDevice);

            // Cập nhật trạng thái thiết bị qua WebSocket
            webSocketService.updateDeviceState(
              updatedDevice.type,
              updatedDevice.state,
              updatedDevice.gate,
              event.accessKey,
            );
          }
        }

        // Phát sự kiện LoadDeviceByRoomId để tải lại thiết bị trong phòng
        add(LoadDeviceByRoomId(roomId: updatedDevices.first.roomID));

        emit(const DeviceUpdated(
            state: StatusState.success, message: 'Cập nhật thành công'));
      } else {
        // Nếu không có thiết bị hoặc lệnh không hợp lệ, chỉ tải lại dữ liệu
        emit(const DeviceUpdated(
            state: StatusState.failure,
            message: 'Không tìm thấy thiết bị hoặc lệnh không hợp lệ'));

        // Lấy roomID mặc định hoặc bất kỳ roomID nào để tải lại thiết bị
        final defaultRoomId = devices.first.roomID;
        add(LoadDeviceByRoomId(roomId: defaultRoomId));
      }
    } catch (e) {
      emit(DeviceUpdated(state: StatusState.failure, message: e.toString()));
    }
  }
}
