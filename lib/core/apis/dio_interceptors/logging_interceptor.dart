import 'package:dio/dio.dart';
import 'package:smarthome_iot/core/services/logger_service.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    printE(
        '[API]-[ERROR]: ${err.response?.statusCode} => PATH: ${err.requestOptions.path} \n\n API ERROR DATA: ${err.response?.data.toString()}');
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    printI(
        "[API]-[REQUEST]: ${options.path} | Method: ${options.method} | \nQuery parameter: ${options.queryParameters} | Body request data: ${options.data}");
    super.onRequest(options, handler);
  }

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   printS(
  //       "[API]-[RESPONSE][Code: ${response.statusCode}] Api: ${response.data.path} | Method: ${response.requestOptions.method} | Query parameter: ${response.requestOptions.queryParameters} | Body request data: ${response.requestOptions.data} | Data response: ${response.data}");
  //   return handler.next(response);
  // }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode;
    final data = response.data;
    final requestOptions = response.requestOptions;
    printS(
      "[API]-[RESPONSE][Code: $statusCode] Api: ${requestOptions.path} | Method: ${requestOptions.method} | Query parameter: ${requestOptions.queryParameters} | Body request data: ${requestOptions.data} | Data response: $data",
    );
    return handler.next(response); // tiếp tục thực thi phản hồi
  }
}
