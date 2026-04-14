import 'package:flutter/material.dart';
import 'package:flutter_application_3/bloc/todo_bloc/bloc/todo_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To Do List")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<TodoBloc>().add(
            AddToDoEvent(
              title: "heyyy ${DateTime.now().microsecondsSinceEpoch}",
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<TodoBloc, TodoInitial>(
              builder: (context, state) {
                return ListView.separated(
                  itemBuilder: (context, index) => ListTile(
                    title: Text(state.title[index]),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<TodoBloc>().add(
                          RemoveToDoEvent(title: state.title[index]),
                        );
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: state.title.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
