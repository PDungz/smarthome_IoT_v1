// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:smarthome_iot/core/services/logger_service.dart';
import 'package:smarthome_iot/features/room/data/models/room_model.dart';
import 'package:smarthome_iot/features/room/domain/entities/room.dart';
import '../../../login/domain/repositories/token_repository.dart';

abstract class RoomRemoteDatasource {
  Future<List<Room>?> getRooms();
  Future<Room?> getRoomById(String roomId);
  Future<bool> postRoom(Room room);
  Future<bool> putRoom(Room room);
  Future<bool> deleteRoom(String roomId);
}

class RoomRemoteDatasourceImpl implements RoomRemoteDatasource {
  final Dio dio;
  final TokenRepository tokenRepository;

  RoomRemoteDatasourceImpl({
    required this.dio,
    required this.tokenRepository,
  });

  @override
  Future<List<Room>?> getRooms() async {
    try {
      // Lấy token truy cập từ repository
      final accessToken = await tokenRepository.getAccessToken();
      if (accessToken == null) {
        throw Exception("Token truy cập không tồn tại");
      }

      final response = await dio.get(
        "/room/get-by-user",
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      final List<dynamic> roomJson = response.data['rooms'];

      return roomJson.map((json) => RoomModel.fromJson(json)).toList();
    } on DioException catch (e) {
      printE(
          "[DioException] loại lỗi: ${e.type}, thông điệp lỗi: ${e.message}");
    } catch (e) {
      printE("Lỗi không xác định: ${e.toString()}");
    }
    return null;
  }

  @override
  Future<bool> postRoom(Room room) async {
    try {
      final accessToken = await tokenRepository.getAccessToken();

      if (accessToken == null) {
        throw Exception("Token truy cập không tốn tại");
      }

      final response = await dio.post(
        '/room/add',
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        }),
        data: {
          "name": room.name,
          "description": room.description,
        },
      );
      return response.statusCode == 201;
    } on DioException catch (e) {
      printE(
          "[DioException] loại lỗi: ${e.type}, thông điệp lỗi: ${e.message}");
      return false;
    } catch (e) {
      printE("Lỗi không xác định: ${e.toString()}");
      return false;
    }
  }

  @override
  Future<bool> putRoom(Room room) async {
    try {
      final accessToken = await tokenRepository.getAccessToken();
      if (accessToken == null) {
        throw Exception("Token truy cập không tốn tại");
      }
      final response = await dio.put('/room/update/${room.id}',
          options: Options(headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          }),
          data: {
            "name": room.name,
            "description": room.description,
          });
      return response.statusCode == 200;
    } on DioException catch (e) {
      printE(
          "[DioException] loại lỗi: ${e.type}, thông điệp lỗi: ${e.message}");
      return false;
    } catch (e) {
      printE("Lỗi không xác định: ${e.toString()}");
      return false;
    }
  }

  @override
  Future<Room?> getRoomById(String roomId) async {
    try {
      // Lấy token truy cập từ repository
      final accessToken = await tokenRepository.getAccessToken();
      if (accessToken == null) {
        throw Exception("Token truy cập không tồn tại");
      }

      final response = await dio.get(
        "/room/$roomId",
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      return RoomModel.fromJson(response.data['room']);
    } on DioException catch (e) {
      printE(
          "[DioException] loại lỗi: ${e.type}, thông điệp lỗi: ${e.message}");
    } catch (e) {
      printE("Lỗi không xác định: ${e.toString()}");
    }
    return null;
  }

  @override
  Future<bool> deleteRoom(String roomId) async {
    try {
      final accessToken = await tokenRepository.getAccessToken();

      if (accessToken == null) {
        throw Exception("Token truy cập không tồn tại");
      }
      final respose = await dio.delete(
        '/room/delete/$roomId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );
      return respose.statusCode == 200;
    } on DioException catch (e) {
      printE(
          "[DioException] loại lỗi: ${e.type}, thông điệp lỗi: ${e.message}");
      return false;
    } catch (e) {
      printE("Lỗi không xác định: ${e.toString()}");
      return false;
    }
  }
}
