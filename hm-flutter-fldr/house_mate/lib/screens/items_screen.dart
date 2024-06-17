import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/todo_bloc.dart';
import '../widgets/todo_item.dart';
import 'edit_todo_screen.dart';
import '../models/todo.dart';

class ItemsScreen extends StatelessWidget {
  final ItemType itemType;

  ItemsScreen({required this.itemType});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        final items =
            state.items.where((item) => item.itemType == itemType).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text('To-Do List'),
            actions: [
              IconButton(
                icon: Icon(state.isEditMode ? Icons.done : Icons.edit),
                onPressed: () {
                  if (state.isEditMode) {
                    context.read<TodoBloc>().add(ExitEditMode());
                  } else {
                    context.read<TodoBloc>().add(EnterEditMode());
                  }
                },
              ),
            ],
          ),
          body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  items[index].task,
                  style: TextStyle(
                    decoration: items[index].isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                trailing: state.isEditMode
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => EditTodoScreen(
                                  index: state.items.indexOf(items[index]),
                                  todo: items[index],
                                ),
                              ));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              context
                                  .read<TodoBloc>()
                                  .add(DeleteItem(items[index].id));
                            },
                          ),
                        ],
                      )
                    : IconButton(
                        icon: Icon(
                          items[index].isCompleted
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                        ),
                        onPressed: () {
                          context
                              .read<TodoBloc>()
                              .add(ToggleItem(items[index].id));
                        },
                      ),
                onTap: !state.isEditMode
                    ? () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    items[index].task,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Completed: ${items[index].isCompleted ? 'Yes' : 'No'}',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Type: ${items[index].itemType == ItemType.Shopping ? 'Shopping' : 'Chore'}',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    : null,
              );
            },
          ),
        );
      },
    );
  }
}
