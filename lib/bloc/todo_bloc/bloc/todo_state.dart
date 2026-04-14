part of 'todo_bloc.dart';

// abstract class TodoState extends Equatable {
//   const TodoState();

//   @override
//   List<Object> get props => [];
// }

class TodoInitial extends Equatable {
  final List<String> title;

  const TodoInitial({required this.title});

  @override
  List<Object> get props => [title];

  TodoInitial copyWith({List<String>? title}) {
    return TodoInitial(title: title ?? this.title);
  }
}
