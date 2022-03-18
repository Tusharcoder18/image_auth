import 'package:flutter/material.dart';

Widget divider() {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      children: const [
        Expanded(
            child: Divider(
          thickness: 2,
        )),
        SizedBox(
          width: 5,
        ),
        Text("OR"),
        SizedBox(
          width: 5,
        ),
        Expanded(
            child: Divider(
          thickness: 2,
        )),
      ],
    ),
  );
}
