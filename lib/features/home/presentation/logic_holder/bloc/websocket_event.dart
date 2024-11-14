part of 'websocket_bloc.dart';

abstract class WebsocketEvent extends Equatable {
  const WebsocketEvent();

  @override
  List<Object?> get props => [];
}

class SensorDataWebsocket extends WebsocketEvent {}
