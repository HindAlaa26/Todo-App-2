import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/cubit/todo_states.dart';
import 'package:todo/shared_component/custom_text.dart';
import 'package:todo/shared_component/custom_text_form_field.dart';
import 'package:todo/shared_component/folder_item.dart';
import 'package:todo/shared_component/task_item.dart';

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

class AddFolder extends StatelessWidget {
  const AddFolder({
    super.key,
    required this.formdKey,
    required this.folderNameController,
  });

  final GlobalKey<FormState> formdKey;
  final TextEditingController folderNameController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubit, TodoStates>(
      builder: (context, state) {
        var todoCubit = ToDoCubit.get(context);
        return Container(
          width: double.infinity,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade200,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                blurRadius: 5,
                color: Colors.blueGrey.shade50,
              ),
            ],
          ),
          child: Form(
            key: formdKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                customText(
                  text: "Folder Name: ",
                  textSize: 20,
                  textFontWeight: FontWeight.w400,
                  textColor: Colors.lightBlue.shade900,
                ),
                CustomTextFormField(
                  controller: folderNameController,
                  text: "Folder Name",
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),

                  child: MaterialButton(
                    color: Colors.lightBlue.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minWidth: double.infinity,
                    onPressed: () {
                      if (formdKey.currentState!.validate()) {
                          todoCubit.addFolder(
                          folderName: folderNameController.text,
                          folderDate: DateFormat.yMMMd().format(DateTime.now()),
                          folderTime: TimeOfDay.now().format(context),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: customText(
                              text: "Folder Added Successfully",
                              textColor: Colors.white,
                            ),
                            backgroundColor: Colors.lightBlue.shade900,
                          ),
                        );

                        Navigator.pop(context);
                        folderNameController.clear();
                      }
                    },
                    child: customText(text: "Add", textColor: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AddTask extends StatelessWidget {
  const AddTask({
    super.key,
    required this.formdKey,
    required this.taskNameController,
  });

  final GlobalKey<FormState> formdKey;
  final TextEditingController taskNameController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubit, TodoStates>(
      
      builder: (context, state) {
        var todoCubit = ToDoCubit.get(context);
        return Container(
          width: double.infinity,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade200,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                blurRadius: 5,
                color: Colors.blueGrey.shade50,
              ),
            ],
          ),
          child: Form(
            key: formdKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,

              children: [
                customText(
                  text: "Task Name: ",
                  textSize: 20,
                  textFontWeight: FontWeight.w400,
                  textColor: Colors.blueGrey.shade900,
                ),
                CustomTextFormField(
                  controller: taskNameController,
                  text: "Task Name",
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        text: "Task Date: ",
                        textSize: 20,
                        textFontWeight: FontWeight.w400,
                        textColor: Colors.blueGrey.shade900,
                      ),
                      customText(
                        text:
                            todoCubit.taskDate != null
                                ? todoCubit.taskDate!
                                : DateFormat.yMMMd().format(DateTime.now()),
                      ),
                      IconButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse('2027-07-01'),
                          ).then((value) {
                            todoCubit.changeTaskDate(value: value);
                          });
                        },
                        icon: Icon(
                          Icons.date_range_outlined,
                          color: Colors.lightBlue.shade900,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customText(
                        text: "Task Time: ",
                        textSize: 20,
                        textFontWeight: FontWeight.w400,
                        textColor: Colors.blueGrey.shade900,
                      ),
                      customText(
                        text:
                            todoCubit.taskTime != null
                                ? todoCubit.taskTime!
                                : TimeOfDay.now().format(context),
                      ),
                      IconButton(
                        onPressed: () {
                          showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          ).then((value) {
                            todoCubit.changeTaskTime(
                              value: value,
                              context: context,
                            );
                          });
                        },
                        icon: Icon(
                          Icons.timer_outlined,
                          color: Colors.lightBlue.shade900,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(18.0),

                  child: MaterialButton(
                    color: Colors.lightBlue.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minWidth: double.infinity,
                    onPressed: () {
                      if (formdKey.currentState!.validate()) {
                        todoCubit.addTask(
                          taskName: taskNameController.text,
                          taskDate:
                              todoCubit.taskDate != null
                                  ? todoCubit.taskDate!
                                  : DateFormat.yMMMd().format(DateTime.now()),
                          taskTime:
                              todoCubit.taskTime != null
                                  ? todoCubit.taskTime!
                                  : TimeOfDay.now().format(context),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(seconds: 1),
                            content: customText(
                              text: "Task Added Successfully",
                              textColor: Colors.white,
                            ),
                            backgroundColor: Colors.lightBlue.shade900,
                          ),
                        );

                        Navigator.pop(context);
                        taskNameController.clear();
                      }
                    },
                    child: customText(text: "Add", textColor: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
