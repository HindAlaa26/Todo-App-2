import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
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

/* List<SpeedDialChild> homeMenu =  [
          SpeedDialChild(
            child: Icon(Icons.task, color: Colors.blueGrey,),
            label: "Add Task",
            
            onTap: () {},
          ),
          SpeedDialChild(
            child: Icon(Icons.folder_copy,color: Colors.blueGrey,),
            label: "Add Folder",
            onTap: () {},
          ),
        ]; */

List newTask =[];
List newFolder =[];

}