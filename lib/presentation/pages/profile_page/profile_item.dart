import 'package:flutter/material.dart';

Widget profileItem(String title, VoidCallback click) {
  return GestureDetector(
    onTap: click,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        const Icon(
          size: 16,
          Icons.arrow_forward_ios,
        )
      ],
    ),
  );
}
