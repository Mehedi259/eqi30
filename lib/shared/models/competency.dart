class Competency {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final double percentage;
  final String status;
  final String color;
  final List<String> abilities;

  Competency({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.percentage,
    required this.status,
    required this.color,
    required this.abilities,
  });

  factory Competency.fromJson(Map<String, dynamic> json) {
    return Competency(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      emoji: json['emoji'] ?? '',
      percentage: (json['percentage'] ?? 0).toDouble(),
      status: json['status'] ?? '',
      color: json['color'] ?? '',
      abilities: List<String>.from(json['abilities'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'emoji': emoji,
      'percentage': percentage,
      'status': status,
      'color': color,
      'abilities': abilities,
    };
  }
}
