import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/domain/entities/movie.dart';
import 'package:warung_bioskop/presentation/widgets/network_image_card.dart';

List<Widget> movieList({
  required String title,
  required AsyncValue<List<Movie>> movies,
  void Function(Movie movie)? onTap,
}) =>
    [
      Text(title),
      if (movies.value != null)
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: movies.value!
              .map(
                (movie) => GestureDetector(
                  onTap: () {
                    debugPrint('movie ${movie.posterPath}');
                    onTap?.call(movie);
                  },
                  child: NetworkImageCard(
                    width: 100,
                    height: 100,
                    borderRadius: 8,
                    fit: BoxFit.fitWidth,
                    imageUrl:
                        'https://image.tmdb.org/t/p/w500' + movie.posterPath!,
                  ),
                ),
              )
              .toList(),
        )
      else
        const Center(
          child: CircularProgressIndicator(), // Fallback for loading state
        ),
    ];
