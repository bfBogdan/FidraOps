class User {
  final String id;
  final String name;
  final String email;
  final String? password;
  final int organizationId;
  final Datetime createdAt;
  final bool iAsdmin;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    required this.organizationId,
    required this.createdAt,
    required this.isAdmin,
  });
}