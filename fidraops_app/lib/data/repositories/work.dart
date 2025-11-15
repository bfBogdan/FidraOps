import 'package:fidraops_app/data/models/work.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/providers/app_state.dart';

class WorkRepository {
  Future<List<Work>> fetchActiveSOPs(
    HttpService httpService,
    AppState appState,
  ) async {
    final response = await httpService.dbGet(
      '/${appState.currentUser?.id}/getActiveSOPs',
    );
    return (response.data as List)
        .map((workJson) => Work.fromJson(workJson))
        .toList();
  }
}
