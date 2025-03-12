import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/cubit/todo_states.dart';
import 'package:todo/shared_component/task_item.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, TodoStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var doneTasks = ToDoCubit.get(context).doneTask;
        return Scaffold(
          body: tasksBuilder(
            tasks: doneTasks,
            iconEmpty: Icons.task_alt,
            textIsEmpty: "Done Tasks",
          ),
        );
      },
    );
  }
}
