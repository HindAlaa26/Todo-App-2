import 'package:flutter/material.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/shared_component/custom_text.dart';

Widget taskItem({required Map model,context,isFolder,folderIndex,taskIndex})
{
  return Dismissible(
    key: Key(model["id"]?.toString() ?? ''),

  background: Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    color: Colors.blueGrey.shade200,
    child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
     
      Icon(Icons.delete,color: Colors.lightBlue.shade900,size:30),
     
    ],
  ),
  ),
  direction: DismissDirection.startToEnd,
  onDismissed: (direction) {
      isFolder? ToDoCubit.get(context).deletTasksfromFolderDatabase(taskId: model['id'],folderId: folderIndex):
       ToDoCubit.get(context).deletetasksData(id: model["id"]);
    }, 
    child: Container(
    padding: EdgeInsets.all(18),
    margin: EdgeInsets.all(20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey),
      boxShadow: [
        BoxShadow(
          color: Colors.blueGrey.shade100,
          spreadRadius: 1.0,
          offset: Offset(2, 3.0),
          blurRadius: 2.0,
        ),
      
      ]
    ),
    child: Row(
      spacing: 5,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blueGrey.shade200,
          child: customText(text: model['TaskTime']?? 'No Time',textColor: Colors.lightBlue.shade900),
        ),
        Expanded(
          child: Column(
            spacing: 6,
            children: [
              customText(text: model['TaskName']?? 'No Name',textSize: 20),
                      customText(text: model['TaskDate']?? 'No Date',textSize: 18,textColor: Colors.lightBlue.shade900),

            ],
          ),
        ),
      
        SizedBox(width: 8),
        IconButton(onPressed: (){
        isFolder?
           ToDoCubit.get(context).updateTasksStatusInFolderDatabase(folderId: folderIndex ,taskId: model['id'],  isDone: true ,  status:"Done",isArchieve: false ):
       
           
       ToDoCubit.get(context).updatetaskStatus(  id: model["id"], status: "Done");
        
        }, icon: Icon(Icons.task_alt,color: isFolder?(( model["doneColor"]?? 0) == 1 ? Colors.green : Colors.blueGrey) : Colors.blueGrey,size: 30,)),
        IconButton(onPressed: (){
         isFolder?
                     ToDoCubit.get(context).updateTasksStatusInFolderDatabase(folderId: folderIndex , taskId: model['id'], isDone: false ,  status: "Archieve",isArchieve: true ):

        ToDoCubit.get(context).updatetaskStatus( id: model["id"], status: "Archieve");
          
        }, icon: Icon(Icons.archive_outlined,color: isFolder? ((model["archiveColor"] ?? 0) == 1 ? Colors.green : Colors.blueGrey) : Colors.blueGrey ,size: 30,)),
      ],
    ),
  ),

    );
}


Widget tasksBuilder({
  required List tasks,
  required IconData iconEmpty,
  required String textIsEmpty,
  bool isFolder = false,
  int? folderIndex ,
})
{

  return tasks.isNotEmpty ? ListView.separated(
      itemBuilder: (context, index) =>  taskItem(model: tasks[index],context: context,isFolder: isFolder,folderIndex: folderIndex,taskIndex: index),
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(left: 25,right: 10),
        child: Divider(thickness: 1,color: Colors.blueGrey,),
      ),
      itemCount: tasks.length) :  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 30,
              children: [
                Icon(
                  iconEmpty,
                  size: 99,
                  color: Colors.blueGrey.shade200,
                ),
                customText(
                  text: textIsEmpty,
                  textSize: 40,
                  textColor: Colors.blueGrey.shade200,
                ),
                
              ],
            ),
          );
}