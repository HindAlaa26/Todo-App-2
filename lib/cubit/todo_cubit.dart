import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/cubit/todo_states.dart';
import 'package:todo/screens/tasks/archieve_tasks.dart';
import 'package:todo/screens/tasks/done_tasks.dart';
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

 void addTask({
    required String taskName,
    required String taskDate,
    required String taskTime,
  }) {
    allTasks.add({
      'Task Name': taskName,
      'Task Date': taskDate,
      'Task Time': taskTime,
      "status": "New",
      'id': DateTime.now().millisecondsSinceEpoch,
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
   
  
   }


   emit(TodoGetTasksState()); 
   
 }
 


/////////////////////////////////////////////////////////////////
void removeTaskInFolder({
  required int folderIndex,
  required int taskIndex,
}) {
  if (folderIndex >= 0 && folderIndex < folders.length) {
    if (taskIndex >= 0 && taskIndex < folders[folderIndex]["tasks"].length) {
      folders[folderIndex]["tasks"].removeAt(taskIndex);
      emit(TodoRemoveTaskInFolderState());
    } else {
      print("Error: Task index out of range");
    }
  } else {
    print("Error: Folder index out of range");
  }
}


 
 void removeFolder({
  required Map folder,
 })
 {
  
   folders.remove(folder);
   emit(TodoRemoveFolderState());
   
 }



 



 void getTasksColorInFolder() {
 

  for (var folder in folders) {
    for (var task in folder["tasks"]) {
      if (task["status"] == "New") {
       task["doneColor"] = false;
        task["archiveColor"] = false;
      } else if (task["status"] == "Done") {
        task["doneColor"] = true;
         task["archiveColor"] = false;
      } else if (task["status"] == "Archieve") {
       task["archiveColor"] = true;
        task["doneColor"] = false;
      }
    }
  }

  emit(TodoGetTasksColorInFoldersState());  
}

 
void updateTaskInFolderStatus({
  required Map task,
  required String status,
  required int folderIndex,
}) {
  if (folderIndex < 0 || folderIndex >= folders.length) {
    print("Error: Folder index is out of range: $folderIndex");
    return;
  }

  int taskIndex = folders[folderIndex]["tasks"].indexWhere((t) =>
      t["Task Name"] == task["Task Name"] &&
      t["Task Date"] == task["Task Date"] &&
      t["Task Time"] == task["Task Time"]);

  if (taskIndex != -1) {
    folders[folderIndex]["tasks"][taskIndex]["status"] = status;
    getTasksColorInFolder();
    emit(TodoUpdateTaskStatusInFolderState());
  } else {
    print("Task not found in folder");
  }
}



 List<Map> folders =[];

void createFolder({required String folderName}) {
   folders.add({
   "Folder Name": folderName,
    "Folder Date": DateFormat.yMMMd().format(DateTime.now()),
    "Folder Time": DateFormat.jm().format(DateTime.now()),
    "status": "New",
    "id": DateTime.now().millisecondsSinceEpoch,
    "tasks": <Map>[]
    }); 


  emit(TodoFolderCreatedState());
 
}



void addTaskToFolder({required String folderName, required Map task, required int folderIndex}) {
  if (folderIndex < 0 || folderIndex >= folders.length) {
    return;
  }

  folders[folderIndex]["tasks"].add(task);
  emit(TodoAddTaskToFolderState());
} 

 
 

}