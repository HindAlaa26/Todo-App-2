import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/cubit/todo_states.dart';
import 'package:todo/shared_component/tasks/task_item.dart';

class ArchieveTasks extends StatelessWidget {
  const ArchieveTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ToDoCubit, TodoStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var archieveTasks = ToDoCubit.get(context).archieveTask;
        return Scaffold(
          body: tasksBuilder(
            tasks: archieveTasks,
            iconEmpty: Icons.archive_outlined,
            textIsEmpty: "Archieve Tasks",
          ),
        );
      },
    );
  }
}