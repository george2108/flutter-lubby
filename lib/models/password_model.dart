class PasswordModel {
  int? id;
  String title;
  String? user;
  String password;
  String? description;
  DateTime? createdAt;

  PasswordModel({
    this.id,
    required this.title,
    this.user,
    required this.password,
    this.description,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return ({
      "id": this.id,
      "title": this.title,
      "user": this.user,
      "password": this.password,
      "description": this.description,
      "createdAt": this.createdAt.toString(),
    });
  }

  factory PasswordModel.fromMap(Map<String, dynamic> json) => PasswordModel(
        id: json["id"],
        title: json["title"],
        user: json["user"],
        password: json["password"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
      );
}
