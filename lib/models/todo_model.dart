class Todo {
  final String todoId;
  String todoTitle;
  String todoDescription;
  final String todoCreatedDate;
  bool isDone;

  Todo({
    required this.todoId,
    required this.todoTitle,
    required this.todoDescription,
    required this.todoCreatedDate,
    required this.isDone,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      todoId: json['id'],
      todoTitle: json['title'],
      todoDescription: json['description'],
      todoCreatedDate: json['created-date'],
      isDone: json['is-done'] == 'true' || json['is-done'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': todoId,
      'title': todoTitle,
      'description': todoDescription,
      'created-date': todoCreatedDate,
      'is-done': isDone,
    };
  }
}
