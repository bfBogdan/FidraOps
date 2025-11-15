class ProjectModel {
  final int id;
  final String title;
  final String? description;
  final int organisationId;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.organisationId,
  });
}
