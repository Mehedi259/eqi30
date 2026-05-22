class Ability {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final String status;
  final int progress;
  final String competency;

  Ability({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.status,
    required this.progress,
    required this.competency,
  });

  factory Ability.fromJson(Map<String, dynamic> json) {
    return Ability(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      emoji: json['emoji'] ?? '',
      status: json['status'] ?? 'Not started',
      progress: json['progress'] ?? 0,
      competency: json['competency'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'emoji': emoji,
      'status': status,
      'progress': progress,
      'competency': competency,
    };
  }

  Ability copyWith({
    String? id,
    String? title,
    String? description,
    String? emoji,
    String? status,
    int? progress,
    String? competency,
  }) {
    return Ability(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      emoji: emoji ?? this.emoji,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      competency: competency ?? this.competency,
    );
  }
}
