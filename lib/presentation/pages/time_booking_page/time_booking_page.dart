import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:warung_bioskop/domain/entities/movie_detail.dart';
import 'package:warung_bioskop/domain/entities/transaction.dart';
import 'package:warung_bioskop/presentation/extensions/build_context_extension.dart';
import 'package:warung_bioskop/presentation/misc/constants.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';
import 'package:warung_bioskop/presentation/misc/router_name.dart';
import 'package:warung_bioskop/presentation/pages/time_booking_page/methods/options.dart';
import 'package:warung_bioskop/presentation/providers/router/router_provider.dart';
import 'package:warung_bioskop/presentation/providers/user_data/user_data_provider.dart';
import 'package:warung_bioskop/presentation/widgets/back_navigation_bar_widget.dart';
import 'package:warung_bioskop/presentation/widgets/network_image_card.dart';

class TimeBookingPage extends ConsumerStatefulWidget {
  final MovieDetail movieDetail;

  const TimeBookingPage(this.movieDetail, {super.key});

  @override
  ConsumerState<TimeBookingPage> createState() => _TimeBookingPageState();
}

class _TimeBookingPageState extends ConsumerState<TimeBookingPage> {
  final List<String> theaters = [
    'XXI The Pasific In',
    'XXI Currious',
    'Premier Urban',
    'CGV Timores',
    'CGV Java'
  ];

  final List<DateTime> dates = List.generate(7, (index) {
    DateTime now = DateTime.now();
    DateTime date = DateTime(now.year, now.month, now.day);
    return date.add(Duration(days: index));
  });

  final List<int> hours = List.generate(12, (index) => index + 12);

  String? selectedTheater;
  DateTime? dateSelected;
  int? hourSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 24,
                left: 16,
                right: 16,
                bottom: 24,
              ),
              child: BackNavigationBarWidget(
                title: widget.movieDetail.title,
                clickListener: () {
                  ref.read(routerProvider).pop();
                },
              ),
            ),
            Center(
              child: NetworkImageCard(
                width: MediaQuery.of(context).size.width - 48,
                height: (MediaQuery.of(context).size.width - 48) * 0.6,
                borderRadius: 15,
                imageUrl: tmdbImageSizeW500Url +
                    (widget.movieDetail.backdropPath ??
                        widget.movieDetail.posterPath ??
                        ''),
                fit: BoxFit.cover,
              ),
            ),
            ...options(
              onTap: (data) {
                setState(() {
                  selectedTheater = data;
                });
              },
              title: 'Select a theater',
              options: theaters,
              selectedItem: selectedTheater,
            ),
            verticalSpace(24),
            ...options(
                title: 'Select date',
                options: dates,
                selectedItem: dateSelected,
                converter: (date) => DateFormat('EEE, d MMMM y').format(date),
                onTap: (date) {
                  hourSelected = 0;
                  setState(() {
                    dateSelected = date;
                  });
                }),
            verticalSpace(24),
            ...options(
                title: 'Select show time',
                options: hours,
                selectedItem: hourSelected,
                converter: (object) => '$object:00',
                isOptionEnable: (hour) =>
                    dateSelected != null &&
                    DateTime(
                      dateSelected!.year,
                      dateSelected!.month,
                      dateSelected!.day,
                      hour,
                    ).isAfter(DateTime.now()),
                onTap: (hour) {
                  setState(() {
                    hourSelected = hour;
                  });
                }),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 40,
              ),
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Colors.white,
                  ),
                ),
                onPressed: () {
                  _onBookingProcess();
                },
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }

  void _onBookingProcess() {
    if (selectedTheater == null ||
        dateSelected == null ||
        hourSelected == null) {
      context.showSnackBar('Please select all options');
    } else {
      final user = ref.read(userDataProvider).value;

      final transaction = Transaction(
        uid: user!.uid,
        title: widget.movieDetail.title,
        adminFee: 3000,
        total: 0,
        watchingTime: DateTime(
          dateSelected!.year,
          dateSelected!.month,
          dateSelected!.day,
          hourSelected!,
        ).millisecondsSinceEpoch,
        transactionImage: widget.movieDetail.posterPath,
        theaterName: selectedTheater,
      );

      ref.read(routerProvider).pushNamed(
        RouterName.seatBooking,
        extra: (
          widget.movieDetail,
          transaction,
        ),
      );
    }
  }
}
