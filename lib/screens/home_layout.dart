import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/cubit/todo_states.dart';
import 'package:todo/shared_component/custom_text.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToDoCubit, TodoStates>(
     
      builder: (context, state) {
        var todoCubit = ToDoCubit.get(context);
        return Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(top: 10,bottom: 25,left: 25,right: 25),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: BottomNavigationBar(
                
                items: todoCubit.navItems,
                currentIndex: todoCubit.currentIndex,
                onTap: (value) {
                  todoCubit.changeIndex(value);
                },
              ),
            ),
          ),
          body: todoCubit.screens[todoCubit.currentIndex],
          appBar: AppBar(
            leading: SizedBox(),
             title: customText(text: todoCubit.pageNameOnAppbae[todoCubit.currentIndex],textColor: Colors.blueGrey,textSize: 25),
             
          ),
       
        );
      },
    );
  }
}
