class NoteModel {
  int? id;
  String title;
  String body;
  DateTime createdAt;
  int favorite;
  dynamic color;

  NoteModel({
    this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.favorite,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return ({
      "id": this.id,
      "title": this.title,
      "body": this.body,
      "createdAt": this.createdAt.toString(),
      "favorite": this.favorite,
      "color": this.color,
    });
  }

  factory NoteModel.fromMap(Map<String, dynamic> json) => NoteModel(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        createdAt: DateTime.parse(json["createdAt"]),
        favorite: json["favorite"],
        color: json["color"],
      );

  @override
  String toString() => '''
    id: ${this.id} 
    title: ${this.title}
    body: ${this.body}
    createdAt: ${this.createdAt}
    favorite: ${this.favorite}
    color: ${this.color}
    ''';
}
