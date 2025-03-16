import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/cubit/todo_states.dart';
import 'package:todo/shared_component/folders/add_folder.dart';
import 'package:todo/shared_component/tasks/add_task.dart';
  import 'package:todo/shared_component/folders/folder_item.dart';
import 'package:todo/shared_component/tasks/task_item.dart';

class NewTask extends StatelessWidget {
  NewTask({super.key});
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formdKey = GlobalKey<FormState>();
  var folderNameController = TextEditingController();
  var taskNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = ToDoCubit.get(context).newTask;
        var folders = ToDoCubit.get(context).folders;
        return Scaffold(
          key: scaffoldKey,
          body: Column(
            children: [
              Expanded(
                child: folderBuilder(
                  folder: folders, 
                  iconEmpty: Icons.folder_copy, 
                  textIsEmpty: "No Folder",),
              ),
                Expanded(
                  child: tasksBuilder(
                              tasks: tasks,
                              iconEmpty: Icons.task_outlined,
                              textIsEmpty: "No Task",
                  ),
                )
            ],
          ),
          
         

          floatingActionButton: SpeedDial(
            heroTag: "New Task",
            animatedIcon: AnimatedIcons.menu_close,
            animatedIconTheme: IconThemeData(color: Colors.blueGrey),
            backgroundColor: Colors.blueGrey.shade200,
            spacing: 10,
            overlayColor: Colors.blueGrey.shade200,
            overlayOpacity: 0.5,
            elevation: 2,
            children: [
              SpeedDialChild(
                child: Icon(Icons.task, color: Colors.blueGrey),
                label: "Add Task",

                onTap: () {
                  scaffoldKey.currentState!.showBottomSheet((context) {
                    return AddTask(
                      formdKey: formdKey,
                      taskNameController: taskNameController,
                    );
                  }).closed;
                },
              ),
              SpeedDialChild(
                child: Icon(Icons.folder_copy, color: Colors.blueGrey),
                label: "Add Folder",
                onTap: () {
                  scaffoldKey.currentState!.showBottomSheet((context) {
                    return AddFolder(
                      formdKey: formdKey,
                      folderNameController: folderNameController,
                    );
                  }).closed;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

