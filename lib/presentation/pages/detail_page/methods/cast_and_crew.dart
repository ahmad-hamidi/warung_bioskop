import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/domain/entities/movie_detail.dart';
import 'package:warung_bioskop/presentation/misc/constants.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';
import 'package:warung_bioskop/presentation/providers/movie/actors_provider.dart';
import 'package:warung_bioskop/presentation/widgets/network_image_card.dart';

List<Widget> castAndCrew({
  required AsyncValue<MovieDetail?> asyncMovieDetail,
  required WidgetRef ref,
}) =>
    [
      const Padding(
        padding: EdgeInsets.only(
          left: 24,
        ),
        child: Text(
          'Cast and crew',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      verticalSpace(16),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            horizontalSpace(16),
            ...?(ref
                .watch(actorsProvider(movieId: asyncMovieDetail.value?.id ?? 0))
                .whenOrNull(
                  data: (actors) => actors
                      .where((element) => element.profilePath != null)
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            children: [
                              NetworkImageCard(
                                width: 100,
                                height: 152,
                                imageUrl: tmdbImageSizeW185Url +
                                    (e.profilePath ?? ''),
                                fit: BoxFit.cover,
                                borderRadius: 18,
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  e.name,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                )),
            horizontalSpace(14),
          ],
        ),
      ),
    ];
