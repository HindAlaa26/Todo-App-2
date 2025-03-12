import 'package:flutter/material.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/shared_component/custom_text.dart';

Widget taskItem(Map model,context)
{
  return Dismissible(
    key: Key(model["id"].toString()),

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
    ToDoCubit.get(context).removeTask(task: model);
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
          child: customText(text: model['Task Time'],textColor: Colors.lightBlue.shade900),
        ),
        Expanded(
          child: Column(
            spacing: 6,
            children: [
              customText(text: model['Task Name'],textSize: 20),
                      customText(text: model['Task Date'],textSize: 18,textColor: Colors.lightBlue.shade900),

            ],
          ),
        ),
      
        SizedBox(width: 8),
        IconButton(onPressed: (){
          ToDoCubit.get(context).updateTaskStatus( task: model, status: "Done");
         
        }, icon: Icon(Icons.task_alt,color: Colors.blueGrey,size: 30,)),
        IconButton(onPressed: (){
        ToDoCubit.get(context).updateTaskStatus( task: model, status: "Archieve");
        }, icon: Icon(Icons.archive_outlined,color: Colors.blueGrey,size: 30,)),
      ],
    ),
  ),

    );
}
Widget tasksBuilder({
  required List tasks,
  required IconData iconEmpty,
  required String textIsEmpty,
})
{

  return tasks.isNotEmpty ? ListView.separated(
      itemBuilder: (context, index) => taskItem(tasks[index],context),
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