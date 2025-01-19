import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warung_bioskop/data/firebase/tmdb_repository.dart';
import 'package:warung_bioskop/data/repositories/movie_repository.dart';

part 'movie_repository_provider.g.dart';

@riverpod
MovieRepository movieRepository(MovieRepositoryRef ref) => TmdbRepository();
