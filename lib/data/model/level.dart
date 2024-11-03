class Level {
  Level({
    required this.id,
    required this.levelNumber,
    required this.difficulty,
    required this.levelDesc,
    required this.targetScore,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  int? levelNumber;
  String? difficulty;
  String? levelDesc;
  int? targetScore;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        id: json["id"],
        levelNumber: json['level_number'],
        difficulty: json['difficulty'],
        levelDesc: json['level_desc'],
        targetScore: json['target_score'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        'level_number': levelNumber,
        'difficulty': difficulty,
        'level_desc': levelDesc,
        'target_score': targetScore,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };
}
