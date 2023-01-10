import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/provider/theme_provider.dart';
import 'package:to_do_app/provider/todo_provider.dart';
import 'package:to_do_app/views/create_task.dart';
import 'package:to_do_app/views/home_paege.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<TodoProvider>(create: (context) => TodoProvider()),
      ChangeNotifierProvider<ThemeProvider>(create: (context) => ThemeProvider()),
    ],
    builder: (context, child) =>
       MaterialApp(
         themeMode: (Provider.of<ThemeProvider>(context).isDark) ? ThemeMode.dark : ThemeMode.light,
         theme: ThemeData(
             backgroundColor: Color(0xffced8f3), focusColor: Colors.black,primaryColor: Color(0xff231e82)),
         darkTheme: ThemeData(
             backgroundColor: Color(0xff38393f),
             focusColor: Colors.white,
             primaryColor: Color(0xff444445)),
        routes: {
          "/": (context) => HomePage(),
          "insertTask": (context) => insertTask(),
        },
      )

  ));
}
