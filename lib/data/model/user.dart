// Model untuk UserScore
class UserScore {
  UserScore({
    this.id,
    this.idUser,
    this.idLevel,
    this.score,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? idUser;
  final int? idLevel;
  final int? score;
  final String? completedAt;
  final String? createdAt;
  final String? updatedAt;

  factory UserScore.fromJson(Map<String, dynamic> json) => UserScore(
        id: json["id"],
        idUser: json["id_user"],
        idLevel: json["id_level"],
        score: json["score"],
        completedAt: json["completed_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "id_level": idLevel,
        "score": score,
        "completed_at": completedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

// Model User yang diperbarui
class User {
  User({
    this.idUser,
    this.name,
    this.role,
    this.email,
    this.emailVerifiedAt,
    this.password,
    this.createdAt,
    this.updatedAt,
    this.userScores,
  });

  final int? idUser;
  final String? name;
  final String? role;
  final String? email;
  final String? emailVerifiedAt;
  final String? password;
  final String? createdAt;
  final String? updatedAt;
  final List<UserScore>? userScores;

  factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json["id"],
        name: json["name"],
        role: json["role"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        password: json["password"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        userScores: json["user_scores"] != null
            ? List<UserScore>.from(
                json["user_scores"].map((x) => UserScore.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": idUser,
        "name": name,
        "role": role,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "password": password,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user_scores": userScores != null
            ? List<dynamic>.from(userScores!.map((x) => x.toJson()))
            : null,
      };
}
