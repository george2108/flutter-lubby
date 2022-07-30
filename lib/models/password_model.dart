class PasswordModel {
  int? id;
  String password;
  String title;
  int favorite;
  String? user;
  String? description;
  DateTime? createdAt;
  String? url;
  String? notas;

  PasswordModel({
    required this.title,
    required this.password,
    required this.favorite,
    this.id,
    this.user,
    this.description,
    this.createdAt,
    this.url,
    this.notas,
  });

  Map<String, dynamic> toMap() {
    return ({
      "id": this.id,
      "title": this.title,
      "password": this.password,
      "favorite": this.favorite,
      "user": this.user,
      "description": this.description,
      "createdAt": this.createdAt.toString(),
      "url": this.url.toString(),
      "notas": this.notas.toString(),
    });
  }

  factory PasswordModel.fromMap(Map<String, dynamic> json) => PasswordModel(
        id: json["id"],
        title: json["title"],
        password: json["password"],
        favorite: json["favorite"],
        user: json["user"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        url: json["url"],
        notas: json["notas"],
      );

  PasswordModel copyWith({
    int? id,
    String? password,
    String? title,
    int? favorite,
    String? user,
    String? description,
    DateTime? createdAt,
    String? url,
    String? notas,
  }) =>
      PasswordModel(
        id: id ?? this.id,
        password: password ?? this.password,
        title: title ?? this.title,
        favorite: favorite ?? this.favorite,
        user: user ?? this.user,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        url: url ?? this.url,
        notas: notas ?? this.notas,
      );

  @override
  String toString() {
    return '''
      id: ${this.id},
      title: ${this.title},
      password: ${this.password},
      favorite: ${this.favorite},
      user: ${this.user},
      description: ${this.description},
      createdAt: ${this.createdAt},
      url: ${this.url},
      notas: ${this.notas},
    ''';
  }
}
