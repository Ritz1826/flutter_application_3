import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_3/view/screens/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoInitial> {
  List<String> toDos = [];

  TodoBloc() : super(TodoInitial(title: [])) {
    // on<TodoEvent>((event, emit) {
    //   // TODO: implement event handler
    // });

    on<AddToDoEvent>(_addToDoEmitter);
    on<RemoveToDoEvent>(_removeToDoEmitter);
  }

  void _addToDoEmitter(AddToDoEvent event, Emitter<TodoInitial> emit) {
    toDos.add(event.title);
    emit(state.copyWith(title: List.from(toDos)));
  }

  void _removeToDoEmitter(RemoveToDoEvent event, Emitter<TodoInitial> emit) {
    toDos.remove(event.title);
    emit(state.copyWith(title: List.from(toDos)));
  }
}
