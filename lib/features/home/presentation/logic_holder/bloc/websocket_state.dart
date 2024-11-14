part of 'websocket_bloc.dart';

abstract class WebsocketState extends Equatable {
  const WebsocketState();

  @override
  List<Object?> get props => [];
}

class WebsocketLoading extends WebsocketState {}

class SensorDataLoaded extends WebsocketState {
  final Websocket webSocketData;

  const SensorDataLoaded({
    required this.webSocketData,
  });

  @override
  List<Object> get props => [webSocketData];
}

class WebsocketError extends WebsocketState {
  final String message;

  const WebsocketError(this.message);

  @override
  List<Object> get props => [message];
}
