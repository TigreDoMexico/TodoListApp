import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DatePickerButton extends StatelessWidget {
  Function onSelectDate;
  DateTime prevSelectedDate;

  DatePickerButton({
    @required this.onSelectDate,
    @required this.prevSelectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        color: Colors.blue,
        child: Container(
          child: Icon(
              Icons.calendar_today,
              color: Colors.white,
          )
        ),
        onPressed: () {
          DatePicker.showDatePicker(
            context,
            showTitleActions: true,
            minTime: DateTime.now(),
            maxTime: DateTime(2050, 6, 7),
            onChanged: (date) {
              print('changed $date');
            },
            onConfirm: (date) {
              onSelectDate(date);
            },
            currentTime: prevSelectedDate,
          );


//          Future<DateTime> selectDate = showDatePicker(
//              context: context,
//              initialDate: DateTime.now(),
//              firstDate: DateTime(2019),
//              lastDate: DateTime(2040),
//              builder: (BuildContext context, Widget child) {
//                return Theme(
//                  data: ThemeData.dark(),
//                  child: child,
//                );
//              }
//          );

        }
    );
  }
}
