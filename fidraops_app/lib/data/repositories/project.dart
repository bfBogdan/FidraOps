class ProjectRepository {
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      organisationId: json['organisation_id'] as String,
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

  Future<List<Project>> fetchProjects(HttpService httpService, AppState appState) async {
    final response = await httpService.get('${appState.currentUser.id}/getProjects');
    print(response.data);
    return (response.data as List)
        .map((projectJson) => Project.fromJson(projectJson as Map<String, dynamic>))
        .toList();
  }
}