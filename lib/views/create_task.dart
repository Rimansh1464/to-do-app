import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/helpers/Db_helper.dart';
import 'package:to_do_app/utils/colors.dart';
import 'package:to_do_app/provider/todo_provider.dart';

import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class insertTask extends StatefulWidget {
  const insertTask({Key? key}) : super(key: key);

  @override
  State<insertTask> createState() => _insertTaskState();
}

class _insertTaskState extends State<insertTask> {
  TextEditingController title = TextEditingController();
  TextEditingController StartTime = TextEditingController();
  TextEditingController EndTime = TextEditingController();
  TextEditingController Descripsion = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (Provider.of<ThemeProvider>(context).isDark == false)?primary:Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  Text(
                    "Create New Task",
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                  Icon(
                    Icons.arrow_back,
                    color: primary,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Title",
                    style: TextStyle(color: (Provider.of<ThemeProvider>(context).isDark == true)?Colors.black38:Colors.white),
                  ),
                  TextFormField(
                    controller: title,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusColor: Colors.white,
                      fillColor: Colors.white,


                      // hintText: "Enter title",
                      // hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    height: 1,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 45,
            ),
            Container(
              height: 510,
              width: double.infinity,
              decoration: BoxDecoration(
                  color:(Provider.of<ThemeProvider>(context).isDark == false) ?
                  Color(0xffe6ebf6):
                  Color(0xff676768),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      topLeft: Radius.circular(40))),
              child: Padding(
                padding: const EdgeInsets.only(top: 40, right: 20, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: StartTime,
                      decoration: InputDecoration(labelText: "Enter Start Time",
                        labelStyle:TextStyle(color:
                      (Provider.of<ThemeProvider>(context).isDark == true)?Colors.white:Colors.black),),

                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        if (pickedTime != null) {
                          DateTime parsedTime = DateFormat.jm()
                              .parse(pickedTime.format(context).toString());

                          String formattedTimes =
                              DateFormat('HH:mm').format(parsedTime);

                          setState(() {
                            StartTime.text = formattedTimes;
                            print(StartTime.text);
                          });
                        } else {
                          print("Time is not selected");
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: EndTime,
                      decoration: InputDecoration(labelText: "Enter End Time", labelStyle:TextStyle(color:
                      (Provider.of<ThemeProvider>(context).isDark == true)?Colors.white:Colors.black)),
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                            context: context, initialTime: TimeOfDay.now());
                        if (pickedTime != null) {
                          DateTime parsedTime = DateFormat.jm()
                              .parse(pickedTime.format(context).toString());

                          String formattedTime =
                              DateFormat('HH:mm').format(parsedTime);

                          setState(() {
                            EndTime.text = formattedTime;
                          });
                        } else {
                          print("Time is not selected");
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: Descripsion,
                      maxLines: 5,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: (){
                        DBHelper.dbHelper.insertData(title: title.text, starTime: StartTime.text.toString(), endTime: EndTime.text.toString(), description:Descripsion.text );

                        Provider.of<TodoProvider>(context,listen: false).fetchData();
                     Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "Create Task",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: primary),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
