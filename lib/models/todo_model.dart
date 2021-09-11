class ToDoModel {
  int? id;
  String title;
  String? description;
  int complete;
  DateTime? createdAt;

  ToDoModel({
    this.id,
    required this.title,
    this.description,
    required this.complete,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return ({
      "id": this.id,
      "title": this.title,
      "complete": this.complete,
      "description": this.description,
      "createdAt": this.createdAt.toString(),
    });
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
}
