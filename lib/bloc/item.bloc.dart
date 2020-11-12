import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/events/task.event.dart';
import 'package:todo_app/models/item.dart';

class ItemBloc extends Bloc<TaskEvent, List<Item>>{
  @override
  List<Item> get initialState => List<Item>();

  @override
  Stream<List<Item>> mapEventToState(TaskEvent event) async* {
    switch(event.eventType){
      case EventType.add:
        List<Item> newState = List.from(state);
        if(event.item != null){
          newState.add(event.item);
        }

        yield newState;
        break;

      case EventType.delete:
        List<Item> newState = List.from(state);
        newState.removeAt(event.itemIndex);

        yield newState;
        break;

      case EventType.changeStatus:
        List<Item> newState = List.from(state);

        var item = newState[event.itemIndex];
        newState[event.itemIndex].done = !item.done;

        yield newState;
        break;

      case EventType.update:
        List<Item> newState = List.from(state);
        newState[event.itemIndex] = event.item;

        yield newState;
        break;

      default:
        throw Exception("Event not found");
    }
  }

}