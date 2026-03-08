class TimeEntry {
  final String id;
  final double totalTime;
  final String projectId;
  final String projectName;
  final String taskId;
  final String taskName;
  final String notes;
  final DateTime date;

  TimeEntry({
    required this.id,
    required this.totalTime,
    required this.projectId,
    required this.projectName,
    required this.taskId,
    required this.taskName,
    required this.notes,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'totalTime': totalTime,
      'projectId': projectId,
      'projectName': projectName,
      'taskId': taskId,
      'taskName': taskName,
      'notes': notes,
      'date': date.toIso8601String(),
    };
  }

  factory TimeEntry.fromJson(Map<String, dynamic> json) {
    return TimeEntry(
      id: json['id'],
      totalTime: json['totalTime'],
      projectId: json['projectId'],
      projectName: json['projectName'],
      taskId: json['taskId'],
      taskName: json['taskName'],
      notes: json['notes'],
      date: DateTime.parse(json['date']),
    );
  }
}
