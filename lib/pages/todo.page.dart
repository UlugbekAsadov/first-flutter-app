import 'package:flutter/material.dart';

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<String> _tasks = [];

  void deleteItem(int index) {
    setState(() {
      if (index >= 0 && index < _tasks.length) {
        _tasks.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          return ListItemWithButton(text: _tasks[index], index: index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String newTask = '';
              return AlertDialog(
                title: Text('Add a Task'),
                content: TextField(
                  decoration: InputDecoration(
                    hintText: 'What are you planning to do?',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  ),
                  onChanged: (text) {
                    newTask = text;
                  },
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (newTask.isNotEmpty) {
                        setState(() {
                          _tasks.add(newTask);
                        });
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ListItemWithButton extends StatelessWidget {
  final String text;
  final int index;

  ListItemWithButton({required this.text, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text, style: TextStyle(fontSize: 18.0)),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
        ),
        onPressed: () {
          print('Button Clicked for $index');
        },
        child: Text('Delete'),
      ),
    );
  }
}
