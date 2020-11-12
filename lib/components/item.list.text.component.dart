import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemListText extends StatelessWidget {
  var itemName = "";
  var itemDate = "";

  ItemListText({
    @required this.itemName,
    @required this.itemDate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          itemName,
          style: TextStyle(
              fontSize: 18.0
          ),
        ),
        SizedBox(height: 5.0,),
        Text(
          itemDate,
          style: TextStyle(
              fontSize: 12.0
          ),
        )
      ],
    );
  }
}
