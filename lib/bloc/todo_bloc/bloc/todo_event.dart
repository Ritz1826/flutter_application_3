part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class AddToDoEvent extends TodoEvent {
  final String title;

  const AddToDoEvent({required this.title});

  @override
  List<Object> get props => [title];
}

class RemoveToDoEvent extends TodoEvent {
  final String title;

  const RemoveToDoEvent({required this.title});

  @override
  List<Object> get props => [title];
}
