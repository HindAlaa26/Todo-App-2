import 'package:flutter/material.dart';
import 'package:todo/shared_component/custom_text.dart';

class CustomTextFormField extends StatefulWidget {
  final String text;
  final bool isPassword;
  final TextEditingController controller;
  const CustomTextFormField({super.key, required this.text, required this.controller,
   this.isPassword = false, });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
   bool visibleIcon = true;
   
  @override
  Widget build(BuildContext context) {
    
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: TextFormField(
      cursorColor: Colors.lightBlue.shade900,
    textInputAction: TextInputAction.done,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller ,
      obscureText: widget.isPassword? visibleIcon : false,
      validator: (value)
      {
        if(value == null || value.isEmpty)
        {
          return '${widget.text} Should not be Empty';
        }
        return null;
      },
      decoration: InputDecoration(
    
         label: customText(text: widget.text,textColor: Colors.lightBlue.shade900,textSize: 18) ,
        filled: true,
        
        fillColor: Colors.grey.shade100,
        suffixIcon:widget.isPassword? IconButton(onPressed: (){
         
         setState(() {
           visibleIcon = !visibleIcon;
          
         });
        }, icon: Icon( visibleIcon? Icons.visibility_off : Icons.visibility, color: Colors.lightBlue.shade900,)) : SizedBox(),
         focusedBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(30),borderSide: BorderSide(color: Colors.lightBlue.shade900)),
         errorBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(30),borderSide: BorderSide(color: Colors.red.shade500)),
         border: UnderlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(30))
      ),
    ),
  );

  }
}
