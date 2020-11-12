import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:todo_app/bloc/item.bloc.dart';
import 'package:todo_app/components/dialog-doyouwant.component.dart';
import 'package:todo_app/components/item.list.text.component.dart';
import 'package:todo_app/components/item.menu.component.dart';
import 'package:todo_app/components/task-appbar.component.dart';
import 'package:todo_app/events/task.event.dart';
import 'package:todo_app/models/item.dart';
import 'package:todo_app/components/slidebox.component.dart';
import 'package:todo_app/screens/edit/edit.screen.dart';

class HomeScreen extends StatefulWidget {
  var items = new List<Item>();

  HomeScreen(){
    items = [];
  }

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var newTaskCtrl = TextEditingController();
  FocusNode focusButtonNode;

  @override
  void initState(){
    super.initState();

    focusButtonNode = FocusNode();
  }

  @override
  void dispose(){
    focusButtonNode.dispose();
    super.dispose();
  }

  Future onTryToDeleteItem(BuildContext ctxt, int index) async {
    final bool res = await showDialog(
        context: ctxt,
        builder: (BuildContext ctx) {
          return AlertDoYouWant(
            question: "Tem certeza que deseja deletar este item?",
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
              FlatButton(
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  BlocProvider.of<ItemBloc>(context)
                      .add(TaskEvent.removeItem(index));

                  Scaffold.of(ctxt).showSnackBar(SnackBar(
                    content: new Text("Item eliminado!"),
                  ));

                  Navigator.of(ctx).pop();
                },
              )
            ],
          );
        });

    return res;
  }

  void onTryToEditItem(Item item, int index){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditScreen.onEditRegister(item, index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: TaskAppBar(
        taskCtrl: newTaskCtrl,
        focusNode: focusButtonNode,
      ),
      body: BlocConsumer<ItemBloc, List<Item>>(
        builder: (context, itemList) {
          if(itemList.length == 0){
            return Center(
                child: Text(
                  "Sem Tarefas no Momento",
                  textAlign: TextAlign.center,
                ));
          }

          itemList.sort((a, b) => a.limitDate.compareTo(b.limitDate));

          return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: itemList.length,
              itemBuilder: (BuildContext ctxt, int index) {
                final item = itemList[index];

                return ItemMenuComponent(
                  ctxt: ctxt,
                  item: item,
                  index: index,
                  onTryToDeleteItem: onTryToDeleteItem,
                  onTryToEditItem: onTryToEditItem,
                );
              });
        },
        listener: (BuildContext context, List state) {

        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => EditScreen()),
          );
        },
        child: Icon(
          Icons.create_rounded,
          color: Colors.white,
        ),
        backgroundColor: Colors.pink,
      ),
    );
  }

  @deprecated
  void addItem() {
    var inputText = newTaskCtrl.text;

    if (inputText.isEmpty){
      focusButtonNode.requestFocus();
      return;
    }

    setState(() {
      widget.items.add(Item(title: inputText, done: false));

      newTaskCtrl.clear();
      save();
    });
  }

  @deprecated
  void removeItem(int index) {
    setState(() {
      widget.items.removeAt(index);
      save();
    });
  }

  @deprecated
  Future loadItems() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((el) => Item.fromJson(el)).toList();

      setState(() {
        widget.items = result;
      });
    }
  }

  @deprecated
  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.items));
  }
}

