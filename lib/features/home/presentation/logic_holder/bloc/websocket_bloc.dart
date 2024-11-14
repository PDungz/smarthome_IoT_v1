import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:smarthome_iot/features/entry_point/domain/repositories/user_repository.dart';
import '../../../../../core/services/logger_service.dart';
import '../../../../../core/services/websocket_service.dart';
import '../../../domain/entites/websocket.dart';

part 'websocket_event.dart';
part 'websocket_state.dart';

class WebsocketBloc extends Bloc<WebsocketEvent, WebsocketState> {
  final UserRepository userRepository;
  final WebSocketService webSocketService;

  WebsocketBloc(this.userRepository, this.webSocketService)
      : super(WebsocketLoading()) {
    on<SensorDataWebsocket>(_onSensorData);
  }

  Future<void> _onSensorData(
      SensorDataWebsocket event, Emitter<WebsocketState> emit) async {
    try {
      final user = await userRepository.getUser();
      if (user != null) {
        webSocketService.connect(user.id);
        webSocketService.stream.listen(
          (data) {
            final responseWebSocket = jsonDecode(data)['data'];
            printE("Phản hồi WebSocket: $responseWebSocket");

            final websocketData = Websocket.fromMap(responseWebSocket);
            emit(SensorDataLoaded(webSocketData: websocketData));
          },
          onError: (error) {
            printE("Lỗi WebSocket: $error");
            emit(WebsocketError("Lỗi kết nối WebSocket: $error"));
          },
        );
      } else {
        emit(const WebsocketError("Không tìm thấy người dùng"));
      }
    } catch (e) {
      emit(WebsocketError("Không thể tải dữ liệu cảm biến: $e"));
    }
  }
}
