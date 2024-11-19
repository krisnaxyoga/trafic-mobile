class Level {
  final int id;
  final int levelNumber;
  final String difficulty;
  final String levelDesc;
  final int targetScore;
  final String createdAt;
  final String updatedAt;

  Level({
    required this.id,
    required this.levelNumber,
    required this.difficulty,
    required this.levelDesc,
    required this.targetScore,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id: json['id'] ?? 0,
      levelNumber: json['level_number'] ?? 0,
      difficulty: json['difficulty'] ?? '',
      levelDesc: json['level_desc'] ?? '',
      targetScore: json['target_score'] ?? 0,
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}

class Sign {
  final int id;
  final String signName;
  final String signImage; // Nama file gambar
  final String signCategory;
  final String description;

  Sign({
    required this.id,
    required this.signName,
    required this.signImage,
    required this.signCategory,
    required this.description,
  });

  // Getter untuk mendapatkan URL gambar
  String get imageUrl {
    // Sesuaikan dengan URL server yang Anda gunakan
    return 'http://10.0.2.2:8000/storage/$signImage'; // Untuk Android Emulator
    // return 'http://localhost:8000/storage/$signImage'; // Untuk iOS Simulator
    // return 'http://192.168.x.x:8000/storage/$signImage'; // Untuk perangkat fisik
  }

  factory Sign.fromJson(Map<String, dynamic> json) {
    return Sign(
      id: json['id'],
      signName: json['sign_name'],
      signImage: json['sign_image'], // Gambar disimpan di path yang sesuai
      signCategory: json['sign_category'],
      description: json['description'],
    );
  }
}

class Question {
  final int id;
  final int idLevel;
  final String questionText;
  final int idSign;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String correctOption;
  final String createdAt;
  final String updatedAt;
  final Level level; // Objek level
  final Sign sign; // Objek sign

  Question({
    required this.id,
    required this.idLevel,
    required this.questionText,
    required this.idSign,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.correctOption,
    required this.createdAt,
    required this.updatedAt,
    required this.level, // Inisialisasi level
    required this.sign, // Inisialisasi sign
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] ?? 0,
      idLevel: json['id_level'] ?? 0,
      questionText: json['question_text'] ?? '',
      idSign: json['id_sign'] ?? 0,
      optionA: json['option_a'] ?? '',
      optionB: json['option_b'] ?? '',
      optionC: json['option_c'] ?? '',
      optionD: json['option_d'] ?? '',
      correctOption: json['correct_option'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      level: Level.fromJson(json['level'] ?? {}), // Parsing objek level
      sign: Sign.fromJson(json['sign'] ?? {}), // Parsing objek sign
    );
  }
}
