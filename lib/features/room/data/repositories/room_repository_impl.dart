// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:smarthome_iot/features/room/data/datasource/room_remote_datasource.dart';
import 'package:smarthome_iot/features/room/domain/entities/room.dart';
import 'package:smarthome_iot/features/room/domain/repositories/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomRemoteDatasource remoteDatasource;

  RoomRepositoryImpl({
    required this.remoteDatasource,
  });

  @override
  Future<List<Room>?> getRooms() async {
    return await remoteDatasource.getRooms();
  }

  @override
  Future<bool> postRoom(Room room) async {
    return await remoteDatasource.postRoom(room);
  }

  @override
  Future<bool> putRoom(Room room) async {
    return await remoteDatasource.putRoom(room);
  }

  @override
  Future<Room?> getRoomById(String roomId) async {
    return await remoteDatasource.getRoomById(roomId);
  }

  @override
  Future<bool> deleteRoom(String roomId) async {
    return await remoteDatasource.deleteRoom(roomId);
  }
}
