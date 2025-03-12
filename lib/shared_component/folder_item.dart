import 'package:flutter/material.dart';

Widget folderItem()
{
  return Row(
    children: [
      Icon(Icons.folder),
      SizedBox(width: 8),
      Text('Folder Name'),
    ],
  );
}