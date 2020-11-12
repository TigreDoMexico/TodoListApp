import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/components/slidebox.component.dart';
import 'package:todo_app/models/item.dart';
import 'item.list.text.component.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/bloc/item.bloc.dart';
import 'package:todo_app/events/task.event.dart';

class ItemMenuComponent extends StatelessWidget {
  BuildContext ctxt;
  Item item;
  int index;
  Function onTryToDeleteItem;
  Function onTryToEditItem;

  ItemMenuComponent({
    @required this.ctxt,
    @required this.item,
    @required this.index,
    @required this.onTryToDeleteItem,
    @required this.onTryToEditItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(10.0),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      child: Dismissible(
        child: CheckboxListTile(
          title: ItemListText(
            itemName: item.title,
            itemDate: DateFormat('dd/MM/yyyy').format(item.limitDate),
          ),
          value: item.done,
          onChanged: (value) {
            BlocProvider.of<ItemBloc>(context)
                .add(TaskEvent.changeStatus(index));
          },
        ),
        key: Key(index.toString()),

        background: SlideRight(),
        secondaryBackground: SlideLeft(),
        confirmDismiss: (direction) async {

          if (direction == DismissDirection.endToStart) {
            return await onTryToDeleteItem(ctxt, index);
          } else if (direction == DismissDirection.startToEnd) {
            return onTryToEditItem(item, index);
          } else {
            return null;
          }
        },
      ),
    );
  }
}
