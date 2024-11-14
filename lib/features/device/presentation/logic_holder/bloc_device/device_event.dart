// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'device_bloc.dart';

abstract class DeviceEvent extends Equatable {
  const DeviceEvent();

  @override
  List<Object> get props => [];
}

class LoadDevices extends DeviceEvent {}

class LoadDeviceById extends DeviceEvent {
  final String? deviceId;

  const LoadDeviceById({this.deviceId});

  @override
  List<Object> get props => [deviceId ?? ""];
}

class LoadDeviceByRoomId extends DeviceEvent {
  final String? roomId;

  const LoadDeviceByRoomId({this.roomId});

  @override
  List<Object> get props => [roomId ?? ""];
}

class UpdateDevice extends DeviceEvent {
  final String accessKey;
  final Device device;

  const UpdateDevice({
    required this.accessKey,
    required this.device,
  });

  @override
  List<Object> get props => [accessKey, device];
}

class PostDevice extends DeviceEvent {
  final Device device;

  const PostDevice({
    required this.device,
  });

  @override
  List<Object> get props => [device];
}

class PutDevice extends DeviceEvent {
  final Device device;

  const PutDevice({
    required this.device,
  });

  @override
  List<Object> get props => [device];
}

class DeleteDevice extends DeviceEvent {
  final String deviceId;

  const DeleteDevice({
    required this.deviceId,
  });

  @override
  List<Object> get props => [deviceId];
}
