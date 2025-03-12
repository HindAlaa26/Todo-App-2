import 'package:flutter/material.dart';
import 'package:todo/shared_component/custom_text.dart';

class ArchieveTasks extends StatelessWidget {
  const ArchieveTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
        children: [
          Icon(Icons.archive_outlined,size: 99,color: Colors.blueGrey.shade200,),
          customText( text: "Archieve Tasks",textSize: 40,textColor: Colors.blueGrey.shade200),
        ],
      )),
    );
  }
}