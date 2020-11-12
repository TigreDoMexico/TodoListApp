import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/bloc/item.bloc.dart';

import 'package:todo_app/components/datepicker.component.dart';
import 'package:todo_app/components/textinput-component.dart';
import 'package:todo_app/events/task.event.dart';
import 'package:todo_app/models/item.dart';

class EditScreen extends StatefulWidget {
  var selectedDateText = "";
  var taskNameCtrl = TextEditingController();
  var taskDetailCtrl = TextEditingController();

  DateTime selectedDate = DateTime.now();

  Item oldItem;
  int index;
  bool isEdit = false;

  EditScreen();

  EditScreen.onEditRegister(Item item, int index){
    this.isEdit = true;
    this.index = index;

    this.taskNameCtrl = TextEditingController(text: item.title);
    this.taskDetailCtrl = TextEditingController(text: item.description);
    this.selectedDate = item.limitDate;
    this.selectedDateText = DateFormat('dd/MM/yyyy').format(item.limitDate);
  }

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  void _onSelectDate(DateTime date) {
    setState(() {
      widget.selectedDate = date;
      widget.selectedDateText = DateFormat('dd/MM/yyyy').format(date);
    });
  }

  void _onSaveTask(BuildContext context) {
    var name = widget.taskNameCtrl.text;
    var description = widget.taskDetailCtrl.text;

    if(name.isNotEmpty && widget.selectedDateText.isNotEmpty){
      var newItem = Item(title: name, description: description, limitDate: widget.selectedDate, done: false);

      BlocProvider.of<ItemBloc>(context)
          .add(TaskEvent.newItem(newItem));

      Navigator.pop(context);
    }
  }

  void _onEditTask(BuildContext context) {
    var name = widget.taskNameCtrl.text;
    var description = widget.taskDetailCtrl.text;

    if(name.isNotEmpty && widget.selectedDateText.isNotEmpty){
      var newItem = Item(title: name, description: description, limitDate: widget.selectedDate, done: false);

      BlocProvider.of<ItemBloc>(context)
          .add(TaskEvent.updateItem(widget.index, newItem));

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if(!currentFocus.hasPrimaryFocus){
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Criar Nova Tarefa"),
        ),
        body: Center(
            child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TaskTextInput(
                hintText: "Nome da Tarefa",
                taskCtrl: widget.taskNameCtrl,
              ),
              SizedBox(
                height: 20.0,
              ),
              TaskTextInput(
                hintText: "Detalhe da Tarefa",
                taskCtrl: widget.taskDetailCtrl,
              ),
              SizedBox(
                height: 40.0,
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        "Escolha uma data",
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.blueGrey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      DatePickerButton(
                        prevSelectedDate: widget.selectedDate,
                        onSelectDate: _onSelectDate,
                      ),
                      SizedBox(
                        width: 30.0,
                      ),
                      Text(
                        widget.selectedDateText,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 15,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        )),
        bottomNavigationBar:
        Container(
          margin: const EdgeInsets.all(20.0),
          child: RaisedButton(
            color: Colors.deepPurpleAccent,
            child: Container(
                decoration: new BoxDecoration(
                    color: Colors.deepPurpleAccent,
                    borderRadius: new BorderRadius.all(Radius.circular(20.0))),
                child: Text(
                  widget.isEdit ? "Alterar Tarefa" : "Salvar Tarefa",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )),
            onPressed: () {
              if(widget.isEdit)
                this._onEditTask(context);
              else
                this._onSaveTask(context);
            },
          ),
        ),
      ),
    );
  }
}
