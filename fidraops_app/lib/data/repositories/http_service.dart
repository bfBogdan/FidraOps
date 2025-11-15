import 'package:dio/dio.dart';
import 'package:providers/app_state.dart';

class HttpService {
  final Dio dio = Dio();
  final AppState appState;

  HttpService(required this.appState) {
    dio.options.baseUrl = 'http://localhost:3000';
  }

  String _prefixedPath(String path) {
    if (path == "/auth") {
      return path;
    }
    final userType = appState.isAdmin ? 'adminOrg' : 'userOrg';
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;
    return '/$userType/${appState.organizationId}/$cleanPath';
  }

  /// Performs a GET request prefixed with the user's database.
  Future<Response> dbGet(String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    }) {
    return dio.get(
      _prefixedPath(path),
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// Performs a POST request prefixed with the user's database.
  Future<Response> dbPost(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    }) {
      return dio.post(
        _prefixedPath(path),
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
  }

  /// Performs a PUT request prefixed with the user's database.
  Future<Response> dbPut(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    }) {
    return dio.put(
      _prefixedPath(path),
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }

  /// Performs a DELETE request prefixed with the user's database.
  Future<Response> dbDelete(String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    }) {
    return dio.delete(
      _prefixedPath(path),
      data: data,
      queryParameters: queryParameters,
      options: options,
    );
  }
}