import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/cubit/todo_states.dart';
import 'package:todo/shared_component/tasks/add_task.dart';
import 'package:todo/shared_component/custom_text.dart';
import 'package:todo/shared_component/tasks/task_item.dart';

class FolderScreen extends StatelessWidget {
  final int folderId;
  final String folderName;
  List<Map> tasks;
  FolderScreen({super.key, required this.folderId,required this.folderName, required this.tasks});

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formdKey = GlobalKey<FormState>();
  var taskNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubit, TodoStates>(
      builder: (context, state) {
        List<Map> tasksInFolder = ToDoCubit.get(context).tasksInFolder;
        print("📂 Folders tasks List from cubit (After Navigation): $tasksInFolder");
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
          body:  tasksInFolder.isNotEmpty 
    ? tasksBuilder(
        tasks:  tasksInFolder,
        iconEmpty: Icons.task_outlined,
        textIsEmpty: "No Task",
        isFolder: true,
        folderIndex: folderId,
      )
    : Center(child: customText(text: "No tasks found")),
    
          floatingActionButton: FloatingActionButton(
            heroTag: "folder tasks",
            backgroundColor: Colors.blueGrey.shade200,
            elevation: 2,
            onPressed: () {
              scaffoldKey.currentState!.showBottomSheet((context) {
                return AddTask(
                  folderName: folderName,
                  folderIndex: folderId,
    
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
