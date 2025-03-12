import 'package:flutter/material.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/screens/folder_screen.dart';
import 'package:todo/shared_component/custom_text.dart';

Widget folderItem(Map model,context)
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
    child: InkWell(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context) => FolderScreen(folderName: model["Folder Name"],),));
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
            child: Icon(Icons.folder_copy_outlined,color: Colors.lightBlue.shade900,),
            
          ),
         
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 6,
              children: [
                customText(text: model['Folder Name']?? "No Folder",textSize: 20),
                        Row(
      
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(width: 5,),
                            customText(text: model['Folder Date'] ?? "No Date",textSize: 18,textColor: Colors.lightBlue.shade900),
                            customText(text: model['Folder Time'] ?? "No Time",textColor: Colors.lightBlue.shade900, textFontWeight: FontWeight.bold),
                           SizedBox(width: 5,),
                          ],
                        ),
      
              ],
            ),
          ),
        
         
        ],
      ),
        ),
    ),

    );
}


Widget folderBuilder({
  required List folder,
  required IconData iconEmpty,
  required String textIsEmpty,
})
{

  return folder.isNotEmpty ? ListView.separated(
      itemBuilder: (context, index) => folderItem( folder[index],  context),
      separatorBuilder: (context, index) => const Padding(
        padding: EdgeInsets.only(left: 25,right: 10),
        child: Divider(thickness: 1,color: Colors.blueGrey,),
      ),
      itemCount: folder.length) :  Center(
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