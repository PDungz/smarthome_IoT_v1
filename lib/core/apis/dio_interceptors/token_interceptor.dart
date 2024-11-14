// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:smarthome_iot/features/login/domain/repositories/token_repository.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;
  final TokenRepository tokenRepository;

  TokenInterceptor({
    required this.dio,
    required this.tokenRepository,
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final tokenExpiryTime = await tokenRepository.getTokenExpiryTime();
    //? Nếu nhận được lỗi 401 và token đã hết hạn, thử làm mới token
    if (err.response?.statusCode == 401 &&
        tokenExpiryTime != null &&
        DateTime.now().isAfter(tokenExpiryTime)) {
      try {
        //? Thu lam moi token mot lan
        var currRefreshToken = await tokenRepository.getRefreshToken();
        final newTokens = await _refreshToken(currRefreshToken ?? '');
        final newAccessToken = newTokens['accessToken'] as String?;
        final newRefreshToken = currRefreshToken;
        const newExpiryTime = 3600;

        if (newAccessToken != null && newRefreshToken != null) {
          tokenRepository.saveToken(
              newAccessToken, newAccessToken, newExpiryTime);
        }
        //? Thu lai yeu cau goc voi token moi
        err.requestOptions.headers['Authorization'] = "Bearer $newAccessToken";
        final res = await dio.fetch<dynamic>(err.requestOptions);
        handler.resolve(res);
      } on DioException catch (err) {
        handler.reject(err);
      }
    } else {
      handler.next(err);
    }
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = await tokenRepository.getAccessToken();
    options.headers["Authorization"] = "Bearer $accessToken";
    handler.next(options);
  }

  Future<Map<String, dynamic>> _refreshToken(String refreshToken) async {
    // Thuc hien yeu cau lam moi token
    Response response =
        await dio.post('/auth/refresh', data: {'refreshToken': refreshToken});
    return response.data;
  }
}
