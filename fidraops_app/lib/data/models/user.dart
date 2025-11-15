class User {
  final int id;
  final String name;
  final String email;
  final String password;
  final int organizationId;
  final DateTime createdAt;
  final bool isAdmin;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.organizationId,
    required this.createdAt,
    required this.isAdmin,
  });

  // 1. FABRICA ESTE AICI, ÎN MODEL
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      organizationId: json['organization_id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      isAdmin: json['is_admin'] as bool,
    );
  }

  // De asemenea, vei avea nevoie de toJson pentru a trimite date
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
}
