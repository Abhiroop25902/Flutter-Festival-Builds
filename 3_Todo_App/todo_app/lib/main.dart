import 'package:flutter/material.dart';

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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    var todos = [
      for (int i = 1; i <= 20; i++)
        Todo(
            task: 'Task $i',
            description: 'This is the task $i, and I have to complete it')
    ];

    todos.add(const Todo(
        task: 'Complete Assignment 1',
        description: 'Assignment is about Flutter'));

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, idx) => ListTile(
                onTap: () async {
                  var data = await Navigator.push<String>(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TodoPage(todo: todos[idx])));

                  if (data?.isNotEmpty ?? false) {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(data!)));
                  }
                },
                title: Text(todos[idx].task),
              )),
    );
  }
}

class Todo {
  final String task;
  final String description;

  const Todo({required this.task, required this.description});
}

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.task),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(todo.description),
          ButtonBar(
            alignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'YES');
                  },
                  child: const Text('YES')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, 'NO');
                  },
                  child: const Text('NO')),
            ],
          )
        ],
      )),
    );
  }
}
