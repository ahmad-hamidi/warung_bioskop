import 'package:flutter/material.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';
import 'package:warung_bioskop/presentation/widgets/seat_widget.dart';

Widget legend() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SeatWidget(size: 20),
        horizontalSpace(5),
        const Text(
          'Available',
          style: TextStyle(fontSize: 12),
        ),
        horizontalSpace(5),
        const SeatWidget(
          size: 20,
          status: SeatStatus.selected,
        ),
        horizontalSpace(5),
        const Text(
          'Selected',
          style: TextStyle(fontSize: 12),
        ),
        horizontalSpace(5),
        const SeatWidget(
          size: 20,
          status: SeatStatus.reserved,
        ),
        horizontalSpace(5),
        const Text(
          'Reserved',
          style: TextStyle(fontSize: 12),
        ),
        horizontalSpace(5),
      ],
    );
