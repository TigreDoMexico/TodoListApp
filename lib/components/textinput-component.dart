import 'package:flutter/material.dart';

class TaskTextInput extends StatelessWidget {
  var hintText = "";
  var taskCtrl = TextEditingController();

  TaskTextInput({
    @required this.taskCtrl,
    @required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return TextFormField(
      controller: taskCtrl,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: hintText,
        labelStyle: TextStyle(
            color: isDark ? Colors.white : Colors.blueGrey,
            fontSize: 15
        ),
      ),
      style: TextStyle(
        color: isDark ? Colors.white : Colors.black,
        fontSize: 20,
      ),
    );
  }
}
