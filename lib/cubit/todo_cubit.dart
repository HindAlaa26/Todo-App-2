import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/cubit/todo_states.dart';
import 'package:todo/screens/archieve_tasks.dart';
import 'package:todo/screens/done_tasks.dart';
import 'package:todo/screens/new_task.dart';

class ToDoCubit extends Cubit<TodoStates>
{
  ToDoCubit() : super(TodoIntitialState());
  
  static ToDoCubit get(context) => BlocProvider.of(context);
 
   int currentIndex = 0;

  void  changeIndex(int value )
  {
   currentIndex = value;
   emit(TodoChangeIndexState());
  }
 
 List<BottomNavigationBarItem> navItems = [
                BottomNavigationBarItem(
                  icon: Icon(Icons.task_outlined),
                  tooltip: "New Task",
                  label: "New task",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.task_alt ),
                  tooltip: "Done tasks",
                  label: "Done tasks",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined ),
                  label: "Archive tasks",
                  tooltip: "Archive tasks",
                ),
              ];
 
  List<Widget> screens =[
    NewTask(),
    DoneTasks(),
    ArchieveTasks()
  ];
 
 List<String> pageNameOnAppbae= [
  "New Tasks",
  "Done Tasks",
  "Archieve Tasks"
 ];


List<Map> newTask =[];
List<Map> doneTask =[];
List<Map> archieveTask =[];
//List<Map> newFolder =[];

 String? taskTime;
void changeTaskTime({value,context})
{
   taskTime = value?.format(context);
  emit(TodoChangeTaskTimeState());
}

 String? taskDate;
void changeTaskDate({value})
{
  taskDate = DateFormat.yMMMd().format(value!);
  emit(TodoChangeTaskDateState());
}


List<Map> allTasks = [];

 void addTask({
    required String taskName,
    required String taskDate,
    required String taskTime,
  }) {
    allTasks.add({
      'Task Name': taskName,
      'Task Date': taskDate,
      'Task Time': taskTime,
      "status": "New"
    });

    emit(TodoAddTaskState());
    getTasks();
  }
 
 void updateTaskStatus(
  {
    required Map task,
    required String status,
  }
 )
 {
   
      int index = allTasks.indexWhere((element) =>
       element["Task Name"] == task["Task Name"]
      ) ;
      allTasks[index]['status'] = status;
   
  
   emit(TodoUpdateTaskStatusState());
    getTasks();
 }

 void removeTask({
  required Map task,
 })
 {
   allTasks.remove(task);
   emit(TodoRemoveTaskState());
    getTasks();
 }

 void getTasks()
 {
   newTask = [];
   doneTask = [];
   archieveTask = [];
   for (var task in allTasks) {
     if (task["status"] == "New")
     {
       newTask.add(task);
       emit(TodoAddNewTaskState());
     }
     else if (task["status"] == "Done")
     {
      doneTask.add(task);
      emit(TodoTaskDoneState());
     }
     else if(task["status"] == "Archieve")
     {
       archieveTask.add(task);
       emit(TodoTaskArchieveState());
     }
   }
   
 }
}