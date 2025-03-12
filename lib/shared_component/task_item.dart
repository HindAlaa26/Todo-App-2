import 'package:flutter/material.dart';

Widget taskItem()
{
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text('Task Name', style: TextStyle(fontSize: 18)),
        ),
        SizedBox(width: 8),
        Icon(Icons.calendar_today, size: 24),
        SizedBox(width: 8),
        Text('Due Date', style: TextStyle(fontSize: 18)),
      ],
    ),
  );
}