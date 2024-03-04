import 'package:flutter/material.dart';
import 'package:flutter_application_5/utilities/my_button.dart';
class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
   DialogBox({super.key,
   required this.controller,
  required this.onCancel,
  required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(backgroundColor: Colors.yellow[300],
      content: Container(
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          // Get User input
          TextField(
            controller: controller ,
            decoration: InputDecoration(border: OutlineInputBorder(),
            hintText: "Add a new Task"),
          ),

          // buttons --> save and cancel
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
            
            // Save button
            MyButton(onPressed: onSave, text: "Save"),
            const SizedBox(width: 8,),
            // cancel button
            MyButton(onPressed: onCancel, text: "Cancel"),
          ],)

        ],),

      ),
    );
  }
}