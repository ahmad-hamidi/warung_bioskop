import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/domain/entities/movie.dart';
import 'package:warung_bioskop/presentation/misc/auto_size_network_image_card.dart';
import 'package:warung_bioskop/presentation/misc/constants.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';
import 'package:warung_bioskop/presentation/widgets/network_image_card.dart';

List<Widget> movieList({
  required String title,
  required AsyncValue<List<Movie>> movies,
  void Function(Movie movie)? onTap,
}) =>
    [
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      verticalSpace(20),
      if (movies.value != null)
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Wrap(
            spacing: 16,
            runSpacing: 8,
            children: movies.value!
                .map(
                  (movie) => AutoSizeNetworkImageCard(
                    borderRadius: 8,
                    fit: BoxFit.cover,
                    clickCallback: () {
                      debugPrint('movie ${movie.posterPath}');
                      onTap?.call(movie);
                    },
                    imageUrl: tmdbImageSizeW92Url + movie.posterPath!,
                  ),
                )
                .toList(),
          ),
        )
      else
        const Center(
          child: CircularProgressIndicator(), // Fallback for loading state
        ),
    ];

List<Widget> movieList2({
  required String title,
  required AsyncValue<List<Movie>> movies,
  void Function(Movie movie)? onTap,
}) =>
    [
      Padding(
        padding: const EdgeInsets.only(
          left: 24,
          bottom: 15,
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      SizedBox(
        child: movies.when(
            data: (listData) => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: listData
                        .map(
                          (movie) => Padding(
                            padding: EdgeInsets.only(
                              left: movie == listData.first ? 24 : 10,
                              right: movie == listData.last ? 24 : 10,
                            ),
                            child: NetworkImageCard(
                              width: 150,
                              height: 228,
                              borderRadius: 8,
                              fit: BoxFit.fitWidth,
                              clickCallback: () {
                                debugPrint('movie ${movie.posterPath}');
                                onTap?.call(movie);
                              },
                              imageUrl:
                                  tmdbImageSizeW154Url + movie.posterPath!,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
            error: (error, stackTrace) {
              return Text(
                'error $error',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              );
            },
            loading: () {
              return const Center(
                child:
                    CircularProgressIndicator(), // Fallback for loading state
              );
            }),
      )
    ];
