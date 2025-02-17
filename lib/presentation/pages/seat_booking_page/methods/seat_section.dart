import 'package:flutter/material.dart';
import 'package:warung_bioskop/presentation/widgets/seat_widget.dart';

Widget seatSection({
  required List<int> seatNumbers,
  required void Function(int seatNumber) onTap,
  required SeatStatus Function(int seatNumber) seatStatusChecker,
}) =>
    SizedBox(
      width: 120,
      height: 340,
      child: Wrap(
        spacing: 6,
        runAlignment: WrapAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: seatNumbers
            .map(
              (data) => SeatWidget(
                number: data,
                status: seatStatusChecker(data),
                onTap: () => onTap(data),
              ),
            )
            .toList(),
      ),
    );
