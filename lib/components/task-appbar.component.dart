import 'package:flutter/material.dart';

class TaskAppBar extends StatelessWidget implements PreferredSizeWidget{
  var taskCtrl = TextEditingController();
  FocusNode focusNode;

  TaskAppBar({
    @required this.taskCtrl,
    @required this.focusNode
  });
  
  @override
  Size get preferredSize => const Size.fromHeight(55);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text("Lista de Tarefas")


//      TextFormField(
//        controller: taskCtrl,
//        keyboardType: TextInputType.text,
//        focusNode: focusNode,
//        decoration: InputDecoration(
//          labelText: "Criar Nova Tarefa",
//          labelStyle: TextStyle(color: Colors.white),
//        ),
//        style: TextStyle(
//          color: Colors.white,
//          fontSize: 20,
//        ),
//      ),
      // actions: <Widget>[
      //   Icon(Icons.plus_one)
      // ],
    );
  }
}
