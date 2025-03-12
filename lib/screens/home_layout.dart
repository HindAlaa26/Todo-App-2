import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 import 'package:todo/cubit/todo_cubit.dart';
import 'package:todo/cubit/todo_states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToDoCubit(),
      child: BlocConsumer<ToDoCubit, TodoStates>(
        listener: (context, state) {
          
        },
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
            
         
          );
        },
      ),
    );
  }
}
