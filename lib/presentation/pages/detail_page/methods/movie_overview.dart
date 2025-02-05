import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/domain/entities/movie_detail.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';

List<Widget> movieOverView(
        {required AsyncValue<MovieDetail?> asyncMovieDetail}) =>
    [
      const Text(
        'Overview',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      verticalSpace(10),
      asyncMovieDetail.when(
        data: (movieDetail) =>
            Text(movieDetail != null ? movieDetail.overView : '-'),
        error: (error, trace) =>
            const Text('Failed to load movie detail, please try again!'),
        loading: () => const CircularProgressIndicator(),
      )
    ];
