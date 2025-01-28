import 'package:flutter/material.dart';

Widget profileInfo(
  String? url, {
  double width = 100,
  double height = 100,
}) {
  final imageProvider = (url?.isNotEmpty == true)
      ? NetworkImage(url!) as ImageProvider
      : const AssetImage(
          'assets/placeholder.png',
        );

  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey, width: 1),
      image: DecorationImage(
        image: imageProvider,
        fit: BoxFit.contain,
      ),
    ),
  );
}
