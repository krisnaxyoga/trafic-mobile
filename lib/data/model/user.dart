class User {
  User({
    this.idUser,
    this.name,
    this.role,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  int? idUser;
  String? name;
  String? role;
  String? email;
  String? password;
  String? createdAt;
  String? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        idUser: json["id"],
        name: json["name"],
        role: json["role"],
        email: json["email"],
        password: json["password"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": idUser,
        "name": name,
        "role": role,
        "email": email,
        "password": password,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
