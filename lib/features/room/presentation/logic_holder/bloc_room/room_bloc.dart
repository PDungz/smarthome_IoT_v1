import 'package:bloc/bloc.dart';
import 'package:smarthome_iot/core/enums/status_state.dart';
import 'package:smarthome_iot/features/room/domain/entities/room.dart';
import 'package:smarthome_iot/features/room/domain/repositories/room_repository.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepository roomRepository;

  RoomBloc(this.roomRepository) : super(RoomInitial()) {
    on<LoadRooms>(_onLoadRooms);
    on<LoadRoom>(_onLoadRoom);
    on<PostRoom>(_onPostRoom);
    on<PutRoom>(_onPutRoom);
    on<DeleteRoom>(_onDeleteRoom);
  }

  Future<void> _onLoadRooms(LoadRooms event, Emitter<RoomState> emit) async {
    emit(RoomLoading());
    try {
      final rooms = await roomRepository.getRooms();
      emit(RoomsLoaded(rooms: rooms ?? []));
    } catch (e) {
      emit(RoomError(Msg: "Failed to load rooms: ${e.toString()}"));
    }
  }

  Future<void> _onLoadRoom(LoadRoom event, Emitter<RoomState> emit) async {
    emit(RoomLoading());
    try {
      final room = await roomRepository.getRoomById(event.roomId);
      emit(RoomLoaded(room: room!));
    } catch (e) {
      emit(RoomError(Msg: "Failed to load rooms: ${e.toString()}"));
    }
  }

  Future<void> _onPostRoom(PostRoom event, Emitter<RoomState> emit) async {
    emit(RoomPost(status: StatusState.loading));
    try {
      final success = await roomRepository.postRoom(event.room);
      if (success) {
        emit(RoomPost(
            status: StatusState.success, Msg: "Room added successfully"));
        add(LoadRooms()); // Trigger reloading rooms after a successful post
      } else {
        emit(RoomPost(status: StatusState.failure, Msg: "Failed to add room"));
      }
    } catch (e) {
      emit(
          RoomPost(status: StatusState.failure, Msg: "Error: ${e.toString()}"));
    }
  }

  Future<void> _onPutRoom(PutRoom event, Emitter<RoomState> emit) async {
    emit(RoomPut(status: StatusState.loading));
    try {
      final success = await roomRepository.putRoom(event.room);
      if (success) {
        emit(RoomPut(
            status: StatusState.success, Msg: "Room updated successfully"));
        add(LoadRooms());
      } else {
        emit(
            RoomPut(status: StatusState.failure, Msg: "Failed to update room"));
      }
    } catch (e) {
      emit(
          RoomPost(status: StatusState.failure, Msg: "Error: ${e.toString()}"));
    }
  }

  Future<void> _onDeleteRoom(DeleteRoom event, Emitter<RoomState> emit) async {
    emit(RoomDelete(status: StatusState.loading));
    try {
      final success = await roomRepository.deleteRoom(event.roomId);
      if (success) {
        emit(RoomDelete(
            status: StatusState.success, Msg: "Room deleted successfully"));
        add(LoadRooms());
      } else {
        emit(RoomDelete(
            status: StatusState.failure, Msg: "Failed to delete room"));
      }
    } catch (e) {
      emit(RoomDelete(
          status: StatusState.failure, Msg: "Error: ${e.toString()}"));
    }
  }
}
