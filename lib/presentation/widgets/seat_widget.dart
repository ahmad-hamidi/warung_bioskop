import 'package:flutter/material.dart';
import 'package:warung_bioskop/presentation/misc/constants.dart';

enum SeatStatus { available, reserved, selected }

class SeatWidget extends StatelessWidget {
  final int? number;
  final SeatStatus status;
  final double size;
  final VoidCallback? onTap;

  const SeatWidget({
    super.key,
    this.number,
    this.status = SeatStatus.available,
    this.size = 30,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: getStatusColor(),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Text(
            number?.toString() ?? '',
            style: const TextStyle(
              color: backgroundColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Color getStatusColor() {
    return status == SeatStatus.available
        ? Colors.white
        : status == SeatStatus.reserved
            ? Colors.grey
            : saffron;
  }
}
