import 'package:flutter/material.dart';

Widget customText({
  required String text  ,
  Color textColor = Colors.black,
  double textSize = 15,
  FontWeight textFontWeight = FontWeight.normal,
  double textWordSpacing = 0,
  double textLetterSpacing = 0,
})
{
  return Text(text,style: TextStyle(
    color: textColor,
    fontSize: textSize,
    fontWeight: textFontWeight,
    wordSpacing: textWordSpacing,
                       letterSpacing: textLetterSpacing
  ),);
}