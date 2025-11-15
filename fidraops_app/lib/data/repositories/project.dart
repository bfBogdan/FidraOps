import 'package:fidraops_app/data/models/project.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/providers/app_state.dart';

class ProjectRepository {
  Future<List<Project>> fetchProjects(
    HttpService httpService,
    AppState appState,
  ) async {
    final response = await httpService.dbGet(
      '/${appState.currentUser?.id}/getProjects',
    );
    print(response.data as List);
    return (response.data as List)
        .map(
          (projectJson) =>
              Project.fromJson(projectJson as Map<String, dynamic>),
        )
        .toList();
  }
}
