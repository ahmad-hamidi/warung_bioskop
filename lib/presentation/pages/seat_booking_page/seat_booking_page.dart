import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/domain/entities/movie_detail.dart';
import 'package:warung_bioskop/domain/entities/transaction.dart';
import 'package:warung_bioskop/presentation/misc/constants.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';
import 'package:warung_bioskop/presentation/pages/seat_booking_page/methods/legend.dart';
import 'package:warung_bioskop/presentation/pages/seat_booking_page/methods/movie_screen.dart';
import 'package:warung_bioskop/presentation/pages/seat_booking_page/methods/seat_section.dart';
import 'package:warung_bioskop/presentation/providers/router/router_provider.dart';
import 'package:warung_bioskop/presentation/widgets/back_navigation_bar_widget.dart';
import 'package:warung_bioskop/presentation/widgets/seat_widget.dart';

class SeatBookingPage extends ConsumerStatefulWidget {
  final (MovieDetail, Transaction) transactionDetail;
  const SeatBookingPage({super.key, required this.transactionDetail});

  @override
  ConsumerState<SeatBookingPage> createState() => _SeatBookingPageState();
}

class _SeatBookingPageState extends ConsumerState<SeatBookingPage> {
  List<int> selectedSeats = [];
  List<int> reservedSeats = [];

  @override
  void initState() {
    super.initState();

    Random random = Random();
    int reservedNumber = random.nextInt(36) + 1;

    while (reservedSeats.length < 8) {
      if (!reservedSeats.contains(reservedNumber)) {
        reservedSeats.add(reservedNumber);
      }
      reservedNumber = random.nextInt(36) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final (movieDetail, transaction) = widget.transactionDetail;
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                BackNavigationBarWidget(
                  title: movieDetail.title,
                  clickListener: () => ref.read(routerProvider).pop,
                ),
                movieScreen(),
                verticalSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    seatSection(
                      seatNumbers: List.generate(18, (index) => index + 1),
                      onTap: onSeatClick,
                      seatStatusChecker: getSeatStatusChecker,
                    ),
                    horizontalSpace(24),
                    seatSection(
                      seatNumbers: List.generate(18, (index) => index + 19),
                      onTap: onSeatClick,
                      seatStatusChecker: getSeatStatusChecker,
                    ),
                  ],
                ),
                verticalSpace(32),
                legend(),
                verticalSpace(32),
                Text(
                  '${selectedSeats.length} seats selected',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpace(24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: saffron,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text('Next',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onSeatClick(int seatNumber) {
    if (!selectedSeats.contains(seatNumber)) {
      setState(() {
        selectedSeats.add(seatNumber);
      });
    } else {
      setState(() {
        selectedSeats.remove(seatNumber);
      });
    }
  }

  SeatStatus getSeatStatusChecker(int seatNumber) {
    return reservedSeats.contains(seatNumber)
        ? SeatStatus.reserved
        : selectedSeats.contains(seatNumber)
            ? SeatStatus.selected
            : SeatStatus.available;
  }
}
