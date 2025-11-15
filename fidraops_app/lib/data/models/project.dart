class Project {
  final int id;
  final String title;
  final String? description;
  final int organisationId;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.organisationId,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      organisationId: json['organisation_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'organisation_id': organisationId,
    };
  }
}
