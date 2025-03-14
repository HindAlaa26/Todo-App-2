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

 
 void removeFolder({
  required Map folder,
 })
 {
  
   folders.remove(folder);
   emit(TodoRemoveFolderState());
   
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
   print("All Tasks: $allTasks");
print("New Tasks: $newTask");
print("Done Tasks: $doneTask");
print("Archive Tasks: $archieveTask");

   emit(TodoGetTasksState()); 
   
 }

 

 List<Map> folders =[];

void createFolder({required String folderName}) {
   folders.add({
   "Folder Name": folderName,
    "Folder Date": DateFormat.yMMMd().format(DateTime.now()),
    "Folder Time": DateFormat.jm().format(DateTime.now()),
    "status": "New Folder",
    "tasks": <Map>[]
    }); 

  print("📂 Updated Folders List After Adding Folder: $folders");

  emit(TodoFolderCreatedState());
 
}



void addTaskToFolder({required String folderName, required Map task, required int folderIndex}) {
  if (folderIndex < 0 || folderIndex >= folders.length) {
    print("Error: Folder index is out of range: $folderIndex");
    return;
  }

  folders[folderIndex]["tasks"].add(task);
  print(" Task added to folder: $folderName");
  emit(TodoAddTaskToFolderState());
} 

 
 

}