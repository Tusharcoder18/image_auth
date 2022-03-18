import 'package:flutter/material.dart';

Widget textBox(String title, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title),
      const SizedBox(
        height: 12,
      ),
      TextField(
        controller: controller,
        obscureText: title == "Password" ? true : false,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: 'Enter $title',
        ),
      ),
    ],
  );
}
