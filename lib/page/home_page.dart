// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_5/data/database.dart';
import 'package:flutter_application_5/utilities/dialoguebox.dart';
import 'package:flutter_application_5/utilities/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference the hivebox
  final _mybox = Hive.box("mybox");
  ToDoDatabase db = ToDoDatabase();
  @override
  void initState() {
    // if this is the first ever opening the app then create default data
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already  exists data
      db.loadData();
    }
    super.initState();
  }

  // save new task
  void saveNewTask(){
      setState(() {
        db.ToDoList.add([_controller.text,false]);
        _controller.clear();
      });
      Navigator.of(context).pop();
      db.updateDatabase();
    }


  // text controller
  final _controller = TextEditingController();

  

  // CheckBox was tapped
  void checkBoxChanged(bool? value,int index){
    setState(() {
      db.ToDoList[index][1] = !db.ToDoList[index][1];

    });
    db.updateDatabase();
     
    

  }
  //  create new task 
  void createNewTask(){
    showDialog(context: context, builder: (context){
      return DialogBox (
        controller: _controller,
        onSave: saveNewTask,
        onCancel: () => Navigator.of(context).pop(),
        
      );
    },);
  }
  // delete task 
  void deleteTask(int index){
    setState(() {
      db.ToDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text("To DO"),
        elevation: 0,

      ),

      floatingActionButton: FloatingActionButton(onPressed: createNewTask,
      child: Icon(Icons.add),),
      body: ListView.builder(
        itemCount: db.ToDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(taskName: db.ToDoList[index][0],
           taskCompleted:db.ToDoList[index][1] ,
            onChanged: (value) => checkBoxChanged(value,index),
            DeleteFunction: (context) => deleteTask(index),
          );
        },
      )

    );
  }
}