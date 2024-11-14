import 'package:smarthome_iot/features/device/domain/entities/device.dart';

abstract class DeviceRepository {
  Future<List<Device>?> getDevices();
  Future<Device?> getDeviceById(String deviceId);
  Future<List<Device>?> getDevicesByRoomId(String roomId);
  Future<bool> postDevice(Device device);
  Future<bool> putDevice(Device device);
  Future<bool> deleteDevice(String deviceId);
}
