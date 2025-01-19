import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warung_bioskop/domain/usecases/get_movie_list/get_movie_list.dart';
import 'package:warung_bioskop/presentation/providers/repositories/movie_repository/movie_repository_provider.dart';

part 'get_movie_list_provider.g.dart';

@riverpod
GetMovieList getMovieList(GetMovieListRef ref) => GetMovieList(
      repo: ref.watch(movieRepositoryProvider),
    );
