import 'package:dio/dio.dart';
import 'package:fidraops_app/providers/app_state.dart';

class HttpService {
  final Dio dio = Dio();
  final AppState appState;

  HttpService(this.appState) {
    dio.options.baseUrl = 'https://fidraops-production.up.railway.app';
  }

  String _prefixedPath(String path) {
    if (path == "/auth") {
      return path;
    }
    final userType = appState.isAdmin ?? false ? 'adminOrg' : 'userOrg';
    final cleanPath = path.startsWith('/') ? path.substring(1) : path;
    return '/$userType/${appState.organizationId}/$cleanPath';
  }

  Future<Response> dbGet(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) {
    return dio.get(
      _prefixedPath(path),
      queryParameters: queryParameters,
      options: options,
    );
  }

  Future<Response> dbPost(
    String path, {
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

  Future<Response> dbPut(
    String path, {
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

  Future<Response> dbDelete(
    String path, {
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
