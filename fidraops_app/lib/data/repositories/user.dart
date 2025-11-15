import "package:../models/user.dart";

class UserRepository {
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      organizationId: json['organization_id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      isAdmin: json['is_admin'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'organization_id': organizationId,
      'created_at': createdAt.toIso8601String(), 
      'is_admin': isAdmin,
    };
  }

  Future<void> login(HttpService httpService, User username, String password) async {
    try{
      final response = await httpService.post(
        "/auth",
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.isSuccessful) {
        setAuthenticated(response.user, response.organizationId);
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