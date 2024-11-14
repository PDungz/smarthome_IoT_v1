part of 'device_bloc.dart';

abstract class DeviceState extends Equatable {
  const DeviceState();

  @override
  List<Object> get props => [];
}

class DeviceLoading extends DeviceState {}

class DevicesLoaded extends DeviceState {
  final List<Device> devices;

  const DevicesLoaded({required this.devices});

  @override
  List<Object> get props => [devices];
}

class DeviceLoaded extends DeviceState {
  final Device device;

  const DeviceLoaded({required this.device});

  @override
  List<Object> get props => [device];
}

class DeviceUpdated extends DeviceState {
  final StatusState state; // Enum or class representing the status
  final String? message;

  const DeviceUpdated({this.state = StatusState.idle, this.message});

  @override
  List<Object> get props => [state, message ?? ''];
}

class DevicePostSuccess extends DeviceState {
  final StatusState state; // Enum or class representing the status
  final String? message;

  const DevicePostSuccess({this.state = StatusState.idle, this.message});

  @override
  List<Object> get props => [state, message ?? ''];
}

class DevicePutSuccess extends DeviceState {
  final StatusState state; // Enum or class representing the status
  final String? message;

  const DevicePutSuccess({this.state = StatusState.idle, this.message});

  @override
  List<Object> get props => [state, message ?? ''];
}

class DeviceDeleted extends DeviceState {
  final StatusState state; // Enum or class representing the status
  final String? message;

  const DeviceDeleted({this.state = StatusState.idle, this.message});

  @override
  List<Object> get props => [state, message ?? ''];
}

class DeviceError extends DeviceState {
  final String message;

  const DeviceError({required this.message});

  @override
  List<Object> get props => [message];
}
