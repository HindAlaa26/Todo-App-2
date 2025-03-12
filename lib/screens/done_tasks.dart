import 'package:flutter/material.dart';
import 'package:todo/shared_component/custom_text.dart';

class DoneTasks extends StatelessWidget {
  const DoneTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
        children: [
          Icon(Icons.task_alt,size: 99,color: Colors.blueGrey.shade200,),
          customText( text: "Done Tasks",textSize: 40,textColor: Colors.blueGrey.shade200),
        ],
      )),
    );
  }
}