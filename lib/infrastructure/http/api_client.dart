import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://4524f7dd1f0a.ngrok-free.app/api',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );

  Future<Response> get(String path) => _dio.get(path);
  Future<Response> post(String path, dynamic data) =>
      _dio.post(path, data: data);
  Future<Response> put(String path, dynamic data) => _dio.put(path, data: data);
  Future<Response> delete(String path) => _dio.delete(path);
}
