import 'package:flutter/material.dart';

Widget folderItem()
{
  return Row(
    children: <Widget>[
      Icon(Icons.folder),
      SizedBox(width: 8),
      Text('Folder Name'),
    ],
  );
}