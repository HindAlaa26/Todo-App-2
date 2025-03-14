import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/cubit/todo_states.dart';
import 'package:todo/shared_component/add_task.dart';
import 'package:todo/shared_component/custom_text.dart';
import 'package:todo/shared_component/task_item.dart';

class FolderScreen extends StatelessWidget {
  final int folderIndex;
  final String folderName;
  FolderScreen({super.key, required this.folderIndex,required this.folderName});

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formdKey = GlobalKey<FormState>();
  var taskNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubit, TodoStates>(
      builder: (context, state) {
        print(
          "📂 Folders List from cubit: ${ToDoCubit.get(context).folders}",
        );
    
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.blueGrey),
            ),
            title: customText(
              text: folderName,
              textColor: Colors.blueGrey,
              textSize: 25,
            ),
          ),
          body:  ToDoCubit.get(context).folders.isNotEmpty && folderIndex < ToDoCubit.get(context).folders.length
    ? tasksBuilder(
        tasks: ToDoCubit.get(context).folders[folderIndex]["tasks"],
        iconEmpty: Icons.task_outlined,
        textIsEmpty: "No Task",
      )
    : Center(child: customText(text: "No folder found")),
    
          floatingActionButton: FloatingActionButton(
            heroTag: "folder tasks",
            backgroundColor: Colors.blueGrey.shade200,
            elevation: 2,
            onPressed: () {
              scaffoldKey.currentState!.showBottomSheet((context) {
                return AddTask(
                  folderName: folderName,
                  folderIndex: folderIndex,
    
                  isFolder: true,
                  formdKey: formdKey,
                  taskNameController: taskNameController,
                );
              }).closed;
            },
            child: Icon(Icons.add, color: Colors.blueGrey),
          ),
        );
      },
    );
  }
}
