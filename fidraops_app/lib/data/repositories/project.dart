import 'package:fidraops_app/data/models/project.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/providers/app_state.dart';

class ProjectRepository {
  //Fetch
  Future<List<Project>> fetchProjects(
    HttpService httpService,
    AppState appState,
  ) async {
    final userId = appState.currentUser?.id;
    if (userId == null) {
      throw Exception('User is not authenticated.');
    }

    try {
      final response = await httpService.dbGet('/$userId/getProjects');

      if (response.data is! List) {
        throw FormatException(
          'API did not return a list. Received: ${response.data.runtimeType}',
        );
      }

      final List<dynamic> data = response.data;
      return data
          .map(
            (projectJson) =>
                Project.fromJson(projectJson as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      print('Error in fetchProjects: $e');
      throw Exception('Failed to load projects.');
    }
  }

  //Create
  Future<Project> createProject(
    HttpService httpService,
    AppState appState,
    Map<String, dynamic> projectData,
  ) async {
    final userId = appState.currentUser?.id;
    if (userId == null) {
      throw Exception('User is not authenticated.');
    }

    try {
      final response = await httpService.dbPost(
        '/$userId/createProject',
        data: projectData,
      );

      final raw = response.data;

      if (raw == null) {
        throw Exception("API returned NULL response");
      }

      if (raw is Map<String, dynamic> && raw.containsKey("project")) {
        return Project.fromJson(raw["project"]);
      }

      if (raw is Map<String, dynamic> && raw.containsKey("id")) {
        return Project.fromJson(raw);
      }

      print("Unexpected project create response: $raw");
      throw Exception("Invalid project format");
    } catch (e) {
      print('Error in createProject: $e');
      throw Exception('Failed to create project.');
    }
  }

  //Delete
  Future<bool> deleteProject(
    HttpService httpService,
    AppState appState,
    int projectId,
  ) async {
    final userId = appState.currentUser?.id;
    if (userId == null) {
      throw Exception('User is not authenticated.');
    }

    try {
      final response = await httpService.dbDelete(
        '/$userId/$projectId/deleteProject',
      );

      final raw = response.data;

      if (raw == null) {
        return true;
      }

      if (raw is Map<String, dynamic>) {
        if (raw.containsKey('deleted') && raw['deleted'] == true) {
          return true;
        }

        if (raw.containsKey('status') && raw['status'] == "ok") {
          return true;
        }

        if (raw.containsKey('message')) {
          return true;
        }
      }

      print("Unexpected project delete response: $raw");
      return false;
    } catch (e) {
      print('Error in deleteProject: $e');
      throw Exception('Failed to delete project.');
    }
  }
}
