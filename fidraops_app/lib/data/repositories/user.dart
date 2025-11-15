import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/data/models/user.dart';
import 'package:fidraops_app/providers/app_state.dart';

class UserRepository {
  Future<void> login(
    HttpService httpService,
    AppState appState,
    User username,
    String password,
  ) async {
    try {
      final response = await httpService.dio.post(
        "/auth",
        data: {'username': username, 'password': password},
      );

      User user = User.fromJson(response.data['user']);
      int organizationId = response.data['organizationId'];

      if (response.statusCode == 200) {
        appState.setAuthenticated(user, organizationId);
      } else {
        throw Exception('Login failed');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }

  Future<void> logout(HttpService httpService) async {
    // Implement logout logic here
    // On success, call setUnauthenticated
  }
}
