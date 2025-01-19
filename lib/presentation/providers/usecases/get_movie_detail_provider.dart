import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warung_bioskop/domain/usecases/get_movie_detail/get_movie_detail_usecase.dart';

import 'package:warung_bioskop/presentation/providers/repositories/movie_repository/movie_repository_provider.dart';

part 'get_movie_detail_provider.g.dart';

@riverpod
GetMovieDetail getMovieDetail(GetMovieDetailRef ref) => GetMovieDetail(
      repo: ref.watch(movieRepositoryProvider),
    );
