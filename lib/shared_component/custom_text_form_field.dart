import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String text;

  final TextEditingController controller;
  const CustomTextFormField({super.key, required this.text, required this.controller,
    });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
   bool visibleIcon = true;
   
  @override
  Widget build(BuildContext context) {
    
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: TextFormField(
      cursorColor: Colors.lightBlue.shade900,
    textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller ,
     
      validator: (value)
      {
        if(value == null || value.isEmpty)
        {
          return '${widget.text} Should not be Empty';
        }
        return null;
      },
      decoration: InputDecoration(

    
        filled: true,
        
        fillColor: Colors.grey.shade100,
        
         focusedBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(30),borderSide: BorderSide(color: Colors.lightBlue.shade900)),
         errorBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(30),borderSide: BorderSide(color: Colors.red.shade500)),
         border: UnderlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(30))
      ),
    ),
  );

  }
}
