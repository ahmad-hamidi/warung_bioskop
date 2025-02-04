import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/domain/entities/movie.dart';
import 'package:warung_bioskop/presentation/misc/constants.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';
import 'package:warung_bioskop/presentation/pages/detail_page/methods/background.dart';
import 'package:warung_bioskop/presentation/providers/movie/movie_detail_provider.dart';
import 'package:warung_bioskop/presentation/providers/router/router_provider.dart';
import 'package:warung_bioskop/presentation/widgets/back_navigation_bar_widget.dart';
import 'package:warung_bioskop/presentation/widgets/network_image_card.dart';

class DetailPage extends ConsumerWidget {
  final Movie movieEntity;
  const DetailPage({super.key, required this.movieEntity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncMovieDetail = ref.watch(
      MovieDetailProvider(movie: movieEntity),
    );

    final model = asyncMovieDetail.valueOrNull;

    var url = '';
    if (model != null) {
      url =
          tmdbImageSizeW500Url + (model.backdropPath ?? model.posterPath ?? '');
    }

    return Scaffold(
      body: Stack(
        children: [
          ...background(movieEntity),
          ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackNavigationBarWidget(
                    title: movieEntity.title,
                    clickListener: () {
                      ref.read(routerProvider).pop();
                    },
                  ),
                  verticalSpace(24),
                  //backdrop image
                  NetworkImageCard(
                    width: MediaQuery.of(context).size.width - 48,
                    height: (MediaQuery.of(context).size.width - 48) * 0.6,
                    borderRadius: 15,
                    imageUrl: url,
                    fit: BoxFit.cover,
                  ),
                  verticalSpace(24),
                  //...movieShortInfo(),
                  verticalSpace(24),
                  //...movieOverView(),
                  verticalSpace(40),
                ],
              ),
              // ...costAndCrew(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 24,
                ),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    foregroundColor: backgroundColor,
                    backgroundColor: saffron,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Book this movie',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
