import 'package:fidraops_app/data/models/sop.dart';
import 'package:fidraops_app/data/repositories/http_service.dart';
import 'package:fidraops_app/providers/app_state.dart';

class SOPRepository {
  //Fetch
  Future<List<SOP>> fetchSOPs(
    HttpService httpService,
    AppState appState,
    int projectId,
  ) async {
    final userId = appState.currentUser?.id;
    if (userId == null) {
      throw Exception('User is not authenticated.');
    }

    try {
      final response = await httpService.dbGet(
        '/$userId/$projectId/getProjectSOPs',
      );

      if (response.data is! List) {
        throw FormatException(
          'API did not return a list. Received: ${response.data.runtimeType}',
        );
      }

      final List<dynamic> data = response.data;
      return data
          .map((sopJson) => SOP.fromJson(sopJson as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error in fetchSOPs: $e');
      throw Exception('Failed to load SOPs.');
    }
  }

  //Create
  Future<SOP> createSOP(
    HttpService httpService,
    AppState appState,
    int projectId,
    Map<String, dynamic> sopData,
  ) async {
    final userId = appState.currentUser?.id;
    if (userId == null) {
      throw Exception('User is not authenticated.');
    }

    try {
      final response = await httpService.dbPost(
        '/$userId/$projectId/createSOP',
        data: sopData,
      );

      final raw = response.data;

      if (raw == null) {
        throw Exception("API returned NULL response");
      }

      if (raw is Map<String, dynamic>) {
        if (raw.containsKey('sop')) {
          return SOP.fromJson(raw['sop']);
        }

        if (raw.containsKey('created_sop')) {
          return SOP.fromJson(raw['created_sop']);
        }

        if (raw.containsKey('data')) {
          return SOP.fromJson(raw['data']);
        }

        if (raw.containsKey('id')) {
          return SOP.fromJson(raw);
        }
      }

      print("Unexpected SOP create response: $raw");
      throw Exception("Invalid SOP format");
    } catch (e) {
      print('Error in createSOP: $e');
      throw Exception('Failed to create SOP.');
    }
  }
}
