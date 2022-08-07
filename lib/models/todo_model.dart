// ignore: todo
// TODO: AGREGAR favorite, color, totalItems - cantidad de detalles

class ToDoModel {
  int? id;
  String title;
  String? description;
  int complete;
  DateTime? createdAt;
  int percentCompleted;

  ToDoModel({
    this.id,
    required this.title,
    this.description,
    required this.complete,
    this.createdAt,
    required this.percentCompleted,
  });

  ToDoModel copyWith({
    int? id,
    String? title,
    String? description,
    int? complete,
    DateTime? createdAt,
    int? percentCompleted,
  }) =>
      ToDoModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        complete: complete ?? this.complete,
        createdAt: createdAt ?? this.createdAt,
        percentCompleted: percentCompleted ?? this.percentCompleted,
      );

  Map<String, dynamic> toMap() {
    return ({
      "id": this.id,
      "title": this.title,
      "complete": this.complete,
      "description": this.description,
      "createdAt": this.createdAt.toString(),
      "percentCompleted": this.percentCompleted,
    });
  }

  factory ToDoModel.fromMap(Map<String, dynamic> json) => ToDoModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        complete: json["complete"],
        createdAt: DateTime.parse(json["createdAt"]),
        percentCompleted: json["percentCompleted"],
      );

  @override
  String toString() {
    return '''
      id: ${this.id},
      title: ${this.title},
      description: ${this.description},
      complete: ${this.complete},
      createdAt: ${this.createdAt},
      percentCompleted: ${this.percentCompleted},
    ''';
  }
}

class ToDoDetailModel {
  int? id;
  int? toDoId;
  String description;
  int complete;
  int orderDetail;

  ToDoDetailModel({
    this.id,
    this.toDoId,
    required this.description,
    required this.complete,
    required this.orderDetail,
  });

  Map<String, dynamic> toMap() {
    return ({
      "id": this.id,
      "toDoId": this.toDoId,
      "description": this.description,
      "complete": this.complete,
      "orderDetail": this.orderDetail
    });
  }

  ToDoDetailModel copyWith({
    int? complete,
    String? description,
    int? todoId,
  }) =>
      ToDoDetailModel(
        id: this.id,
        toDoId: todoId ?? this.toDoId,
        description: description ?? this.description,
        complete: complete ?? this.complete,
        orderDetail: this.orderDetail,
      );

  @override
  String toString() {
    return '''
      id: ${this.id},
      toDoId: ${this.toDoId},
      description: ${this.description},
      complete: ${this.complete},
      orderDetail: ${this.orderDetail},
    ''';
  }
}
