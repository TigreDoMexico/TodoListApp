import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/item.dart';

import 'components/slideComponent.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO APP',

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  var items = new List<Item>();

  HomePage() {
    items = [];
    // items.add(Item(title: "Item 1", done: false));
    // items.add(Item(title: "Item 2", done: true));
    // items.add(Item(title: "Item 3", done: true));
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newTaskCtrl = TextEditingController();

  void addItem () {
    var inputText = newTaskCtrl.text;

    if(inputText.isEmpty)
      return;

    setState(() {
      widget.items.add(
        Item(
          title: inputText,
          done: false
        ));

      newTaskCtrl.clear();
      save();
    });
  }

  void removeItem (int index) {
    setState(() {
      widget.items.removeAt(index);
      save();
    });
  }

  Future loadItems() async {
    var prefs = await SharedPreferences.getInstance();
    var data = prefs.getString('data');

    if(data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> result = decoded.map((el) => Item.fromJson(el)).toList();

      setState(() {
        widget.items = result;
      });
    }
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('data', jsonEncode(widget.items));
  }

  _HomePageState() {
    loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Text("Hi"),
        title: TextFormField(
          controller: newTaskCtrl,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            labelText: "Criar Nova Tarefa",
            labelStyle: TextStyle(color: Colors.white),
          ),
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        // actions: <Widget>[
        //   Icon(Icons.plus_one)
        // ],
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext ctxt, int index) {
          final item = widget.items[index];

          return Dismissible(
            child: CheckboxListTile(
              title: Text(item.title),
              value: item.done,
              onChanged: (value) {
                setState(() {
                  item.done = value;
                  save();
                });
              },
            ),
            key: Key(item.title),
            background: SlideRight(),
            secondaryBackground: SlideLeft(),
            confirmDismiss: (direction) async {
              if(direction == DismissDirection.endToStart){
                final bool res = await showDialog(
                  context: ctxt,
                  builder: (BuildContext ctx){
                    return AlertDialog(
                      content: Text("Tem certeza que deseja deletar este item?"),
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
                            removeItem(index);
                            Scaffold.of(ctxt).showSnackBar(SnackBar(content: new Text("Item eliminado"),));
                            Navigator.of(ctx).pop();
                          },
                        )
                      ],
                    );
                  }

                );
                return res;
              } else {
                return null;
              }
            },
//            onDismissed: (direction) {
//              //if(direction == DismissDirection.endToStart)
////                removeItem(index);
////                Scaffold.of(ctxt).showSnackBar(SnackBar(content: new Text("Item eliminado"),));
//            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addItem,
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}