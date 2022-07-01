class NoteModel {
  int? id;
  String title;
  String body;
  DateTime createdAt;
  int important;
  int color;

  NoteModel({
    this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.important,
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return ({
      "id": this.id,
      "title": this.title,
      "body": this.body,
      "createdAt": this.createdAt.toString(),
      "important": this.important,
      "color": this.color,
    });
  }

  factory NoteModel.fromMap(Map<String, dynamic> json) => NoteModel(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        createdAt: DateTime.parse(json["createdAt"]),
        important: json["important"],
        color: json["color"],
      );
}
