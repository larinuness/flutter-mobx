import 'package:mobx/mobx.dart';
import 'package:todomobx/stores/todo_store.dart';
part 'list_store.g.dart';

class ListStore = _ListStore with _$ListStore;

abstract class _ListStore with Store {
  //core state
  @observable
  String newTodoTitle = "";

  //action altera o observable
  @action
  void setNewTodoTitle(String value) => newTodoTitle = value;

  ObservableList<TodoStore> todoList = ObservableList<TodoStore>();

  @action
  void addTodo() {
    //quando add sempre vai ficar no topo da lista
    todoList.insert(0, TodoStore(newTodoTitle));
    newTodoTitle = "";
  }

  //deriverd state
  @computed
  bool get isFormValid => newTodoTitle.isNotEmpty;
}
