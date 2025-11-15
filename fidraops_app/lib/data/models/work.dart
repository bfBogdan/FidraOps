class Work {
  final int id;
  final int projectId;
  final String title;
  final String description;
  final int requiredAssigneeNumber;
  final List<int> assignees;
  final int timeEstimateMinutes;
  final List<int> requiredEquipment;
  final int organisationId;
  final DateTime createdAt;
  final DateTime startTimeStamp;
  final int status;

  Work({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    required this.requiredAssigneeNumber,
    required this.assignees,
    required this.timeEstimateMinutes,
    required this.requiredEquipment,
    required this.organisationId,
    required this.createdAt,
    required this.startTimeStamp,
    required this.status,
  });

  factory Work.fromJson(Map<String, dynamic> json) {
    List<int> parseIntList(dynamic raw) {
      try {
        if (raw == null) return [];

        if (raw is List<int>) return raw;

        if (raw is List) {
          return raw
              .map((e) => int.tryParse(e.toString()) ?? 0)
              .toList();
        }

        if (raw is String) {
          return raw
              .split(',')
              .map((e) => int.tryParse(e.trim()) ?? 0)
              .toList();
        }

        return [];
      } catch (_) {
        return [];
      }
    }

    return Work(
      id: json['id'],
      projectId: json['project_id'],
      title: json['title'],
      description: json['description'],
      requiredAssigneeNumber: json['required_assignee_number'],
      assignees: parseIntList(json['users_id']),
      timeEstimateMinutes: json['time_estimation_minutes'],
      requiredEquipment: parseIntList(json['required_equipments']),
      organisationId: json['organisation_id'],
      createdAt: DateTime.parse(json['created_at']),
      startTimeStamp: DateTime.parse(json['start_timestamp']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_id': projectId,
      'title': title,
      'description': description,
      'required_assignee_number': requiredAssigneeNumber,
      'users_id': assignees,
      'time_estimation_minutes': timeEstimateMinutes,
      'required_equipments': requiredEquipment,
      'organisation_id': organisationId,
      'created_at': createdAt.toIso8601String(),
      'start_timestamp': startTimeStamp.toIso8601String(),
      'status': status,
    };
  }
}
