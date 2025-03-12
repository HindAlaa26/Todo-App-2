import 'package:flutter/material.dart';
import 'package:todo/shared_component/custom_text.dart';

class FolderScreen extends StatelessWidget {
  final String folderName;
  const FolderScreen({super.key,required this.folderName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: Icon(Icons.arrow_back,color: Colors.blueGrey,)),
      title: customText(text: folderName,textColor: Colors.blueGrey,textSize: 25),
     ),
    );
  }
}