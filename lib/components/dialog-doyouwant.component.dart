import 'package:flutter/material.dart';

class AlertDoYouWant extends StatelessWidget {

  var question = "";
  var actions = <Widget>[];

  AlertDoYouWant({
    @required this.question,
    @required this.actions
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(question),
      actions: actions,
    );
  }
}
