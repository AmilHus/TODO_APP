
class TodoModel{
  int id;
  String content;
  bool isDone;

  TodoModel({required this.id,required this.content, this.isDone = false});

    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'isDone': isDone ? 1 : 0,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'],
      content: map['content'],
      isDone: map['isDone'] == 1,
    );
  }
}
