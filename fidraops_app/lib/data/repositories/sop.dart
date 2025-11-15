import 'package:fidraops_app/data/models/sop.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/providers/app_state.dart';

class SOPRepository {
  Future<List<SOP>> fetchSOPs(
    HttpService httpService,
    AppState appState,
    int projectId,
  ) async {
    final response = await httpService.dbGet(
      '/${appState.currentUser?.id}/$projectId/getProjectSOPs',
    );
    return (response.data as List)
        .map((sopJson) => SOP.fromJson(sopJson as Map<String, dynamic>))
        .toList();
  }

  Future<List<SOP>> fetchAllSOPs(
    HttpService httpService,
    AppState appState
  ) async {
    final response = await httpService.dbGet(
      '/${appState.currentUser?.id}/getSOPs',
    );
    return (response.data as List)
        .map((sopJson) => SOP.fromJson(sopJson as Map<String, dynamic>))
        .toList();
  }
}
