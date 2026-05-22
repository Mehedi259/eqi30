class UserModel {
  final String id;
  final String fullName;
  final String email;
  final String? phone;
  final String? profileImage;
  final int streak;
  final int level;
  final List<String> completedAbilities;
  final Map<String, int> competencyProgress;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    this.phone,
    this.profileImage,
    this.streak = 0,
    this.level = 0,
    this.completedAbilities = const [],
    this.competencyProgress = const {},
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      profileImage: json['profileImage'],
      streak: json['streak'] ?? 0,
      level: json['level'] ?? 0,
      completedAbilities: List<String>.from(json['completedAbilities'] ?? []),
      competencyProgress: Map<String, int>.from(json['competencyProgress'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'streak': streak,
      'level': level,
      'completedAbilities': completedAbilities,
      'competencyProgress': competencyProgress,
    };
  }

  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? profileImage,
    int? streak,
    int? level,
    List<String>? completedAbilities,
    Map<String, int>? competencyProgress,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      streak: streak ?? this.streak,
      level: level ?? this.level,
      completedAbilities: completedAbilities ?? this.completedAbilities,
      competencyProgress: competencyProgress ?? this.competencyProgress,
    );
  }

  String get initials {
    final names = fullName.split(' ');
    if (names.length >= 2) {
      return '${names[0][0]}${names[1][0]}'.toUpperCase();
    }
    return fullName.isNotEmpty ? fullName[0].toUpperCase() : 'A';
  }
}
