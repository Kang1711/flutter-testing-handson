import 'package:dio/dio.dart';
class DioClient {
  DioClient._();

  static Dio build({String? baseUrl}){
    return Dio(BaseOptions(
      baseUrl: baseUrl ?? 'https://jsonplaceholder.typicode.com',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      responseType: ResponseType.json,
      headers: {'Accept': 'application/json'},
    ));
  }
}

