import 'package:flutter/material.dart';

Widget profileItem(String title, VoidCallback click) {
  return Container(
    margin: const EdgeInsets.only(
      left: 16,
      right: 16,
    ),
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
