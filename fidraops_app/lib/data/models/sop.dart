class SOP {
  final int id;
  final int projectId;
  final String title;
  final String description;
  final int requiredAssigneeNumber;
  final int estimatedCompletionTime; // in minutes
  final List<int>? requiredItems; // List of the ids of the items required
  final int organisationId;

  SOP({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    required this.requiredAssigneeNumber,
    required this.estimatedCompletionTime,
    this.requiredItems,
    required this.organisationId,
  });

  factory SOP.fromJson(Map<String, dynamic> json) {
    print('Parsing SOP from JSON: $json');
    return SOP(
      id: json['id'] as int,
      projectId: json['project_id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      requiredAssigneeNumber: json['required_assignee_number'] as int,
      estimatedCompletionTime: json['time_estimation_minutes'] as int,
      requiredItems: (json['required_equipements'] as List<dynamic>?)
          ?.map((item) => item as int)
          .toList(),
      organisationId: json['organisation_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'project_id': projectId,
      'title': title,
      'description': description,
      'required_assignee_number': requiredAssigneeNumber,
      'time_estimation_minutes': estimatedCompletionTime,
      'required_equipements': requiredItems,
      'organisation_id': organisationId,
    };
  }
}
