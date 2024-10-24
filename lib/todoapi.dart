// To parse this JSON data, do
//
//     final todoModelApi = todoModelApiFromJson(jsonString);

import 'dart:convert';

TodoModelApi todoModelApiFromJson(String str) => TodoModelApi.fromJson(json.decode(str));


class TodoModelApi {
    List<Todo> todos;

    TodoModelApi({
        required this.todos,
    });

    factory TodoModelApi.fromJson(Map<String, dynamic> json) => TodoModelApi(
        todos: List<Todo>.from(json["todos"].map((x) => Todo.fromJson(x))),
    );

}

class Todo {
    int id;
    String todo;
    bool completed;
    int userId;

    Todo({
        required this.id,
        required this.todo,
        required this.completed,
        required this.userId,
    });

    factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        todo: json["todo"],
        completed: json["completed"],
        userId: json["userId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "todo": todo,
        "completed": completed,
        "userId": userId,
    };
}
