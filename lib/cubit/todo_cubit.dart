import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
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
List<Map> folders =[];


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


/// sql part 

 late Database database;
    void createDatabase()  {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) {
        print("database created");
        db.execute('CREATE TABLE If not exists tasks(id INTEGER PRIMARY KEY,TaskName TEXT,TaskDate TEXT, TaskTime TEXT, status TEXT)').then((value) {
          print("tasks table created");
        }).catchError((error) {
          print("Error when creating tasks table ${error.toString()}");
        });
        db.execute('CREATE TABLE If not exists folders(id INTEGER PRIMARY KEY,FolderName TEXT,FolderDate TEXT, FolderTime TEXT,tasks TEXT, status TEXT)').then((value) {
          print("folders table created");
        }).catchError((error) {
          print("Error when creating tasks table ${error.toString()}");
        });
        db.execute('CREATE TABLE If not exists folderTasks(id INTEGER PRIMARY KEY,folderId INTEGER,TaskName TEXT,TaskDate TEXT, TaskTime TEXT, status TEXT, archiveColor boolean , doneColor boolean )').then((value) {
          print("folder tasks table created");
        }).catchError((error) {
          print("Error when creating tasks table ${error.toString()}");
        });
      },
      onOpen: (db) {
        gettasksDataFromDatabase(db);
        getfoldersDataFromDatabase(db);
         
        print("database opened");
      },
    ).then((value) {
      database = value;
     
      emit(TodoCreateDatabaseState());
    });
  } 
 
 /// general tasks  
   insertTasksToDatabase({
    required String taskName,
    required String taskDate,
    required String taskTime,
   
  }) async
  {
    await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO tasks(TaskName,TaskDate,TaskTime,status) VALUES("$taskName","$taskDate","$taskTime","New")')
          .then((value) {
        print("$value inserted successfully");
        emit(TodoInsertDatabaseTasksState());
        gettasksDataFromDatabase(database);
      }).catchError((error) {
        print("error when inserting new task record ${error.toString()}");
      });
    });
  }

   void gettasksDataFromDatabase(database)
  {
    
     newTask.clear();
   doneTask.clear();
   archieveTask.clear();

    emit(TodoGetDatabasetasksLoadingState());
     database.rawQuery('SELECT * FROM tasks').then((value) {
        print(">>>>>>>>>>>>>>>>>>>>>$value");
       value.forEach((element) {
         if(element["status"] == 'New')
           {
              newTask.add(element);
           }
         else if(element["status"] == 'Archieve')
         {
            archieveTask.add(element);
         }
         else
         {
           doneTask.add(element);
         }

       });
       emit(TodoGetDatabasetasksState());
     });
  }
 void updatetaskStatus({
    required String status,
    required int id,
})async
  {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        [status, id]).then((value) {
         gettasksDataFromDatabase(database);
          emit(TodoUpdatetaskStatusDatabaseState());

    });
  }
 void deletetasksData({
    required int id,
  })async
  {
    database.rawDelete(
        'DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      gettasksDataFromDatabase(database);
      emit(TodoDeletetasksDatabaseState());

    });
  }

// folder  
   insertFoldersToDatabase({
    required String folderName,
   
  }) async
  {
    await database.transaction((txn) {
      return txn.rawInsert(
          'INSERT INTO folders(FolderName,FolderDate,FolderTime,tasks,status) VALUES("$folderName","${DateFormat.yMMMd().format(DateTime.now())}","${DateFormat.jm().format(DateTime.now())}"," ","New")')
          .then((value) {
        print("$value inserted successfully");
        emit(TodoInsertDatabaseFolderState());
        getfoldersDataFromDatabase(database);
      }).catchError((error) {
        print("error when inserting new folder record ${error.toString()}");
      });
    });
  }
 void getfoldersDataFromDatabase(database)
  {
    
     folders.clear();

    emit(TodoGetDatabasefoldersLoadingState());
     database.rawQuery('SELECT * FROM folders').then((value) {

       value.forEach((element) {
        folders.add(element);

       });
       emit(TodoGetDatabasefoldersState());
     });
  }
 void deletefoldersData({
    required int id,
  })async
  {
    database.rawDelete(
        'DELETE FROM folders WHERE id = ?', [id]).then((value) {
      getfoldersDataFromDatabase(database);
      emit(TodoDeletefoldersDatabaseState());

    });
  }

// tasks in folder 
  insertTasksToFolderDatabase({
    required int folderId,
    required String taskName,
    required String taskDate,
    required String taskTime,
     required bool archiveColor,
    required bool doneColor,
  }) async
  {
    await database.insert("folderTasks",conflictAlgorithm: ConflictAlgorithm.replace,
    {
      'folderId' : folderId,
      'TaskName' : taskName,
      'TaskDate' : taskDate,
      'TaskTime' : taskTime,
      'status' : "New",
      'archiveColor' : archiveColor ,
      'doneColor' : doneColor
    } 
     
    );
    getTasksfromFolderDatabase(folderId: folderId);
    emit(TodoInsertTasksToFolderState());
  }

  List<Map> tasksInFolder = [];
   Future<List<Map>> getTasksfromFolderDatabase({
    required int folderId,
  }) async
  {
     tasksInFolder = [];
     tasksInFolder = await database.rawQuery("""
                          Select * from folderTasks 
                      where folderId == ?                   
                        """, [folderId]);
     emit(TodoGetTasksFromFolderState());
    return tasksInFolder;
  }
  Future updateTasksStatusInFolderDatabase({
    required int folderId,
    required int taskId,
    required bool isDone,
    required bool isArchieve,
    required String status,
  }) async
  {
     if(isDone)
     {
      await database.update("folderTasks", 
     {
                'doneColor': 1,
                'archiveColor': 0,
                'status' : status,
              },
              where: 'id =?',
              whereArgs: [taskId]);
     }
     else if(isArchieve)
     {
await database.update("folderTasks", 
     {
                'doneColor': 0,
                'archiveColor': 1,
                'status' : status,
              },
              where: 'id =?',
              whereArgs: [taskId]);
     }
    
     
     getTasksfromFolderDatabase(folderId: folderId);

     emit(UpdateTasksInFolderDatabaseStatus());
    
  }

     Future deletTasksfromFolderDatabase({
    required int taskId,
    required int folderId,
  }) async
  {
     await database.delete(
      "folderTasks",
      where: 'id =?',
              whereArgs: [taskId]);
     getTasksfromFolderDatabase(folderId: folderId);
     emit(TodoDeletTasksFromFolderState());
   
  }







}