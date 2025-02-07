import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/domain/entities/movie_detail.dart';
import 'package:warung_bioskop/presentation/misc/constants.dart';
import 'package:warung_bioskop/presentation/pages/time_booking_page/methods/options.dart';
import 'package:warung_bioskop/presentation/providers/router/router_provider.dart';
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

  String? selectedTheater;

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
                debugPrint('sini $data');
                setState(() {
                  selectedTheater = data;
                });
              },
              title: 'Select a theater',
              options: theaters,
              selectedItem: selectedTheater,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Colors.white,
                ),
              ),
              onPressed: () {
                debugPrint('sinixx');
              },
              child: const Text(
                'Next',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        )
      ],
    ));
  }
}
