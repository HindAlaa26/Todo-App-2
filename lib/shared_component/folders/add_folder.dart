import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/cubit/todo_states.dart';
import 'package:todo/shared_component/custom_text.dart';
import 'package:todo/shared_component/custom_text_form_field.dart';

class AddFolder extends StatelessWidget {
  const AddFolder({
    super.key,
    required this.formdKey,
    required this.folderNameController,
  });

  final GlobalKey<FormState> formdKey;
  final TextEditingController folderNameController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubit, TodoStates>(
      builder: (context, state) {
        var todoCubit = ToDoCubit.get(context);
        return Container(
          width: double.infinity,
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade200,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                blurRadius: 5,
                color: Colors.blueGrey.shade50,
              ),
            ],
          ),
          child: Form(
            key: formdKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                customText(
                  text: "Folder Name: ",
                  textSize: 20,
                  textFontWeight: FontWeight.w400,
                  textColor: Colors.lightBlue.shade900,
                ),
                CustomTextFormField(
                  controller: folderNameController,
                  text: "Folder Name",
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),

                  child: MaterialButton(
                    color: Colors.lightBlue.shade900,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minWidth: double.infinity,
                    onPressed: () {
                      if (formdKey.currentState!.validate()) {
                          todoCubit.createFolder(
                          folderName : folderNameController.text,
                        
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                       
                          SnackBar(
                             duration: Duration(seconds: 1),
                            content: customText(
                              text: "Folder Added Successfully",
                              
                              textColor: Colors.white,
                            ),
                            backgroundColor: Colors.lightBlue.shade900,
                          ),
                           
                        );

                        Navigator.pop(context);
                        folderNameController.clear();
                      }
                    },
                    child: customText(text: "Add", textColor: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

