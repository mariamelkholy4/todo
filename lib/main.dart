import 'package:flutter/material.dart';
import 'package:todo/home/HomeScreen.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.routName,
      routes:{HomeScreen.routName : (context)=>HomeScreen(),} ,
    );
  }
}

