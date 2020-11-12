import 'package:todo_app/models/item.dart';

enum EventType {
  add,
  update,
  delete,
  changeStatus,
}

class TaskEvent {
  Item item;
  int itemIndex;
  EventType eventType;

  TaskEvent.newItem(Item item){
    this.eventType = EventType.add;
    this.item = item;
  }

  TaskEvent.removeItem(int index){
    this.eventType = EventType.delete;
    this.itemIndex = index;
  }

  TaskEvent.changeStatus(int index){
    this.eventType = EventType.changeStatus;
    this.itemIndex = index;
  }

  TaskEvent.updateItem(int index, Item item){
    this.eventType = EventType.update;
    this.itemIndex = index;
    this.item = item;
  }

}