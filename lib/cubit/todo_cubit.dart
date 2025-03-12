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
 List<Map> folders =[];


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
 
void updateTaskStatus({
  required Map task,
  required String status,
}) {
  int index = allTasks.indexWhere((element) =>
      element["Task Name"] == task["Task Name"] &&
      element["Task Date"] == task["Task Date"] &&
      element["Task Time"] == task["Task Time"]);

  if (index != -1) {
    allTasks[index]["status"] = status;
    getTasks();  
    emit(TodoUpdateTaskStatusState());
  } else {
    print("Task not found in allTasks");
  }
}




 void removeTask({
  required Map task,
 })
 {
   allTasks.remove(task);
   folders.remove(task);
   emit(TodoRemoveTaskState());
    getTasks();
 }

 void getTasks()
 {
   newTask.clear();
   doneTask.clear();
   archieveTask.clear();
   
   for (var task in allTasks) {
     if (task["status"] == "New")
     {
       newTask.add(task);
      
     }
     else if (task["status"] == "Done")
     {
      doneTask.add(task);
     
     }
     else if(task["status"] == "Archieve")
     {
       archieveTask.add(task);
     }
     else if (task["status"] == "New Folder")
     {
       folders.add(task);
     
     }
   }
   print("All Tasks: $allTasks");
print("New Tasks: $newTask");
print("Done Tasks: $doneTask");
print("Archive Tasks: $archieveTask");

   emit(TodoGetTasksState()); 
   
 }

void addFolder({
    required String folderName,
    required String folderDate,
    required String folderTime,
  }) {
    folders.add({
      'Folder Name': folderName,
      'Folder Date': folderDate,
      'Folder Time': folderTime,
      "status": "New Folder"
    });

    emit(TodoAddFolderState());
    
  }
 
/* void removeFolder({
  required Map folder,
 })
 {
   allTasks.remove(folder);
   emit(TodoRemoveFolderState());
    getTasks();
 } */

}