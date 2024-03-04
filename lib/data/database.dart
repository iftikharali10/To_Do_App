import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List ToDoList = [];
  // referebce our box
  final _mybox = Hive.box("mybox");
  // run this method if this is the first time ever opening this app
  void createInitialData(){
    ToDoList = [
      ["Get Fresh",false],
      ["Have Breakfast",false],
    ];

  }
  // Load the data from the databse
  void loadData (){
    ToDoList = _mybox.get("TODOLIST");
  }
  // Update the dataBase
  void updateDatabase (){
    _mybox.put("TODOLIST", ToDoList);

  }
}