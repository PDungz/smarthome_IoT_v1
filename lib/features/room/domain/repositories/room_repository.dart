import 'package:smarthome_iot/features/room/domain/entities/room.dart';

abstract class RoomRepository {
  Future<List<Room>?> getRooms();
  Future<Room?> getRoomById(String roomId);
  Future<bool> postRoom(Room room);
  Future<bool> putRoom(Room room);
  Future<bool> deleteRoom(String roomId);
}
