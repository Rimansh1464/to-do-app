import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/helpers/Db_helper.dart';
import 'package:to_do_app/models/todo_model.dart';
import 'package:to_do_app/provider/todo_provider.dart';
import 'package:intl/intl.dart';

import '../provider/theme_provider.dart';
import '../utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  init() async {
    await Provider.of<TodoProvider>(context, listen: false).fetchData();
  }
   TextEditingController nameController = TextEditingController();
   TextEditingController startTimeController = TextEditingController();
   TextEditingController endTimeController = TextEditingController();
   TextEditingController descriptionController = TextEditingController();
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: FloatingActionButton(onPressed: (){

          Navigator.pushNamed(context, "insertTask");

      },child: Icon(Icons.add),backgroundColor: Theme.of(context).primaryColor),
      body: Padding(
        padding: const EdgeInsets.only(top: 60, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(),
                Spacer(),
                Switch(
                    activeColor: Colors.black12,
                    inactiveThumbColor: Colors.white,
                    value: Provider.of<ThemeProvider>(context, listen: false).isDark,
                    onChanged: (val) {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .ChangTheme();

                    })

              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Hello, John!",
              style: TextStyle(fontSize: 30,color: Theme.of(context).focusColor,),
            ),
            Text(
              "Hello, John!",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Task",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Theme.of(context).focusColor,),
            ),

            Expanded(
              child: SizedBox(
                child: FutureBuilder(
                  future: Provider.of<TodoProvider>(context).fetchList,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("${snapshot.error}"),
                      );
                    } else if (snapshot.hasData) {
                      List<todoModel>? allData = snapshot.data;
                      return ListView.builder(
                        itemCount: allData?.length,
                        itemBuilder: (context, i) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: InkWell(
                              onTap: () {
                                nameController.text = allData![i].title!;
                                startTimeController.text = allData[i].startTime!;
                                endTimeController.text = allData[i].endTime!;
                                descriptionController.text = allData[i].description!;
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: (Provider.of<ThemeProvider>(context).isDark==true)?Colors.grey :Colors.white,
                                      title: Text("Edit Task"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextFormField(
                                            controller: nameController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: "name",
                                            ),),
                                          SizedBox(height: 10,),
                                          TextFormField(
                                            controller: startTimeController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: "Start time",
                                            ),
                                            onTap: () async {
                                              TimeOfDay? pickedTime = await showTimePicker(
                                                  context: context, initialTime: TimeOfDay.now(),

                                              );
                                              if (pickedTime != null) {
                                                DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());

                                                String formattedTime = DateFormat('HH:mm').format(parsedTime);
                                                setState(() {
                                                  startTimeController.text = formattedTime;
                                                });
                                              } else {
                                                print("Time is not selected");
                                              }
                                            },),
                                          SizedBox(height: 10,),

                                          TextFormField(
                                            controller: endTimeController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: "End time",
                                            ),
                                            onTap: () async {
                                              TimeOfDay? pickedTime = await showTimePicker(
                                                  context: context, initialTime: TimeOfDay.now());
                                              if (pickedTime != null) {
                                                DateTime parsedTime = DateFormat.jm()
                                                    .parse(pickedTime.format(context).toString());

                                                String formattedTime =
                                                DateFormat('HH:mm').format(parsedTime);

                                                setState(() {
                                                  endTimeController.text = formattedTime;

                                                });
                                              } else {
                                                print("Time is not selected");
                                              }
                                            },),
                                          SizedBox(height: 10,),

                                          TextFormField(
                                            controller: descriptionController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: "description",
                                            ),),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(onPressed: (){
                                          DBHelper.dbHelper.update(id:allData[i].id , name: nameController.text, startTime: startTimeController.text.toString(), endTime: endTimeController.text.toString(), description: descriptionController.text);
                                          Navigator.of(context).pop();
                                          nameController.clear();
                                          startTimeController.clear();
                                          endTimeController.clear();
                                          descriptionController.clear();
                                        }, child: Text("Update"),style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Theme.of(context).primaryColor))),
                                        OutlinedButton(onPressed: (){
                                          nameController.clear();
                                          startTimeController.clear();
                                          endTimeController.clear();
                                          descriptionController.clear();
                                          Navigator.of(context).pop();
                                        }, child: Text("Cancel"))
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Container(
                                // height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:(Provider.of<ThemeProvider>(context).isDark == false) ?
                                     Color(0xffe6ebf6):
                                     Color(0xff676768),

                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Theme.of(context).primaryColor),
                                      child: Center(
                                          child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      )),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${allData?[i].title}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500
                                            ,color: Theme.of(context).focusColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "${allData?[i].startTime} to ${allData?[i].startTime}",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: (Provider.of<ThemeProvider>(context).isDark == false)?Colors.black38:Colors.white),
                                          ),
                                          Text(
                                            "${allData?[i].description} ",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: (Provider.of<ThemeProvider>(context).isDark == false)?Colors.black38:Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor: (Provider.of<ThemeProvider>(context).isDark==true)?Colors.grey :Colors.white,
                                                title: Text("Delete"),
                                                content: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                  Text("Are You really want to delete this To-do"),
                                                ],),
                                                actions: [
                                                  ElevatedButton(onPressed: (){
                                                    DBHelper.dbHelper
                                                        .deleteData(id: allData?[i].id);
                                                    Provider.of<TodoProvider>(context, listen: false).fetchData();
                                                    Navigator.of(context).pop();

                                                  }, child: Text("Delete"),style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Theme.of(context).primaryColor))),
                                                  OutlinedButton(onPressed: (){
                                                    Navigator.of(context).pop();
                                                  }, child: Text("Cancel"))
                                                ],
                                              );
                                            },
                                          );


                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                        )),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
