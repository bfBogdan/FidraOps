class Work {
  final int id;
  final int projectId;
  final String title;
  final String description;
  final int requierdAssigneeNumber;
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
    required this.requierdAssigneeNumber,
    required this.assignees,
    required this.timeEstimateMinutes,
    required this.requiredEquipment,
    required this.organisationId,
    required this.createdAt,
    required this.startTimeStamp,
    required this.status,
  });

  factory Work.fromJson(Map<String, dynamic> json) {
    return Work(
      id: json['id'],
      projectId: json['project_id'],
      title: json['title'],
      description: json['description'],
      requierdAssigneeNumber: json['required_assignee_number'],
      assignees: List<int>.from(json['users_id']),
      timeEstimateMinutes: json['time_estimation_minutes'],
      requiredEquipment: List<int>.from(json['required_equipments']),
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
      'required_assignee_number': requierdAssigneeNumber,
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
