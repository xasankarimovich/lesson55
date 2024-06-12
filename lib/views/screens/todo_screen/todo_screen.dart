import 'package:flutter/material.dart';
import 'package:settings_page/models/todo_model.dart';
import 'package:settings_page/viewmodels/todo_view_model.dart';
import 'package:settings_page/views/widgets/manage_todo_dialog.dart';
import 'package:settings_page/views/widgets/todos_widget.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TodoViewModel _todoViewModel = TodoViewModel();

  void onAddPressed() async {
    final Map<String, dynamic> data = await showDialog(
      context: context,
      builder: (BuildContext context) => const ManageTodoDialog(
        isEdit: false,
      ),
    );
    if (data.isNotEmpty) {
      _todoViewModel.addTodo(
        todoTitle: data['todoTitle'],
        todoDescription: data['todoDescription'],
      );
      setState(() {});
    }
  }

  void onTogglePressed(List<Todo> todos, int index) {
    _todoViewModel.toggleTodo(
      todoId: todos[index].todoId,
      todoStatus: !todos[index].isDone,
    );
    setState(() {});
  }

  void onEditPressed(Todo todo) async {
    final Map<String, dynamic> data = await showDialog(
      context: context,
      builder: (BuildContext context) => ManageTodoDialog(
        todo: todo,
        isEdit: true,
      ),
    );
    if (data.isNotEmpty) {
      _todoViewModel.editTodo(
        todoId: todo.todoId,
        newTodoTitle: data['todoTitle'],
        newTodoDescription: data['todoDescription'],
      );
      setState(() {});
    }
  }

  void onDeletePressed({required String todoId}) {
    _todoViewModel.deleteProduct(todoId: todoId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'Todo',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: onAddPressed,
              icon: const Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: FutureBuilder(
          future: _todoViewModel.todoList,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text('Add notes'),
              );
            }
            final List<Todo> todos = snapshot.data;
            return todos.isEmpty
                ? const Center(
                    child: Text('Add notes'),
                  )
                : ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return TodosWidget(
                        onTogglePressed: () {
                          onTogglePressed(todos, index);
                        },
                        onDeletePressed: () {
                          onDeletePressed(todoId: todos[index].todoId);
                        },
                        onEditPressed: () {
                          onEditPressed(todos[index]);
                        },
                        todos: todos,
                        index: index,
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
