import 'package:flutter/material.dart';
import 'package:todo/screens/home_layout.dart';

void main() {
  runApp(const MyApp());

} 

class MyApp extends StatelessWidget {
  const MyApp({super.key});

   @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
elevation: 15,
backgroundColor: Colors.blueGrey.shade100,
type: BottomNavigationBarType.fixed,
showUnselectedLabels: false,

  selectedLabelStyle: TextStyle(
      fontSize:14
  ),

  unselectedIconTheme: IconThemeData(
    size : 29,
    color: Colors.blueGrey.shade400,
  ),
  selectedIconTheme: IconThemeData(
    size : 29,
    
  ),
        ),
        primarySwatch: Colors.blueGrey,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: HomeLayout(),
    );
  }
}

