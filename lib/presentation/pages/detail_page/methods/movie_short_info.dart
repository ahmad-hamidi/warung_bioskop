import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:warung_bioskop/domain/entities/movie_detail.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';

List<Widget> movieShortInfo({
  required AsyncValue<MovieDetail?> asyncMovieDetail,
  required BuildContext context,
}) =>
    [
      Row(
        children: [
          Image.asset(
            'assets/duration.png',
            width: 14,
            height: 14,
          ),
          horizontalSpace(5),
          Text(
            '${asyncMovieDetail.when(
              data: (model) => model != null ? model.runtime : '-',
              error: (error, stackTrace) => '-',
              loading: () => '-',
            )} minutes',
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          horizontalSpace(16),
          Image.asset(
            'assets/genre.png',
            width: 14,
            height: 14,
          ),
          horizontalSpace(5),
          asyncMovieDetail.when(
            data: (model) {
              final genres = model?.genres.join(', ') ?? '-';
              return Expanded(
                child: Text(
                  genres,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              );
            },
            error: (error, stackTrace) => const Text('-'),
            loading: () => const Text('-'),
          ),
        ],
      ),
      verticalSpace(10),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 18,
            width: 18,
            child: Image.asset('assets/star.png'),
          ),
          horizontalSpace(5),
          Text(
            (asyncMovieDetail.valueOrNull?.voteAverage ?? 0).toStringAsFixed(1),
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      )
    ];
