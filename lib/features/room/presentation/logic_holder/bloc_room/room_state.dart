// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'room_bloc.dart';

abstract class RoomState {}

class RoomLoading extends RoomState {}

class RoomInitial extends RoomState {}

class RoomsLoaded extends RoomState {
  final List<Room> rooms;
  RoomsLoaded({
    required this.rooms,
  });
}

class RoomLoaded extends RoomState {
  final Room room;
  RoomLoaded({
    required this.room,
  });
}

class RoomPost extends RoomState {
  final StatusState status;
  final String? Msg;
  RoomPost({
    this.status = StatusState.idle,
    this.Msg,
  });

  RoomPost copyWith({
    StatusState? status,
    String? Msg,
  }) {
    return RoomPost(
      status: status ?? this.status,
      Msg: Msg ?? this.Msg,
    );
  }
}

class RoomPut extends RoomState {
  final StatusState status;
  final String? Msg;
  RoomPut({
    this.status = StatusState.idle,
    this.Msg,
  });

  RoomPut copyWith({
    StatusState? status,
    String? Msg,
  }) {
    return RoomPut(
      status: status ?? this.status,
      Msg: Msg ?? this.Msg,
    );
  }
}

class RoomDelete extends RoomState {
  final StatusState status;
  final String? Msg;
  RoomDelete({
    this.status = StatusState.idle,
    this.Msg,
  });

  RoomDelete copyWith({
    StatusState? status,
    String? Msg,
  }) {
    return RoomDelete(
      status: status ?? this.status,
      Msg: Msg ?? this.Msg,
    );
  }
}

class RoomError extends RoomState {
  final String Msg;
  RoomError({
    required this.Msg,
  });
}
