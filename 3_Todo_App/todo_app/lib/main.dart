import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Todo App'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            Consumer<AppData>(
              builder: (context, appData, child) => IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AddTodoAlert(
                              appData: appData,
                            ));
                  },
                  icon: const Icon(Icons.add)),
            )
          ],
        ),
        body: Consumer<AppData>(
          builder: (context, appData, child) => ListView.builder(
              itemCount: appData.todos.length,
              itemBuilder: (context, idx) => ListTile(
                    onLongPress: () => appData.removeTodo(idx: idx),
                    title: Text(appData.todos[idx].task),
                    subtitle: Text(appData.todos[idx].description),
                  )),
        ),
      ),
    );
  }
}

class Todo {
  final String task;
  final String description;

  const Todo({required this.task, required this.description});
}

class AppData with ChangeNotifier {
  final _todos = [
    const Todo(
        task: 'Complete Assignment 1',
        description: 'Assignment is about Flutter')
  ];

  List<Todo> get todos => _todos;

  void addTodo({required Todo todo}) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo({required int idx}) {
    _todos.removeAt(idx);
    notifyListeners();
  }
}

class AddTodoAlert extends StatefulWidget {
  const AddTodoAlert({Key? key, required this.appData}) : super(key: key);

  final AppData appData;

  @override
  State<AddTodoAlert> createState() => _AddTodoAlertState();
}

class _AddTodoAlertState extends State<AddTodoAlert> {
  late final TextEditingController _taskController;
  late final TextEditingController _descController;

  @override
  void initState() {
    _taskController = TextEditingController();
    _descController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _taskController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Add Todo"),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: _taskController,
            decoration: const InputDecoration(
                label: Text("Enter Task"), border: OutlineInputBorder()),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            controller: _descController,
            decoration: const InputDecoration(
                label: Text("Enter Description"), border: OutlineInputBorder()),
          ),
        )
      ]),
      actions: [
        ElevatedButton(
            onPressed: () {
              if (_taskController.text.isNotEmpty) {
                widget.appData.addTodo(
                    todo: Todo(
                        task: _taskController.text,
                        description: _descController.text));
                Navigator.pop(context);
              }
            },
            child: const Text('ADD'))
      ],
      actionsAlignment: MainAxisAlignment.center,
    );
  }
}
