import 'package:warung_bioskop/data/repositories/movie_repository.dart';
import 'package:warung_bioskop/domain/entities/movie.dart';
import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/domain/usecases/get_movie_list/get_movie_list_param.dart';
import 'package:warung_bioskop/domain/usecases/usecase.dart';

class GetMovieList implements UseCase<Result<List<Movie>>, GetMovieListParam> {
  final MovieRepository movieRepository;

  GetMovieList({required MovieRepository repo}) : movieRepository = repo;

  @override
  Future<Result<List<Movie>>> call(GetMovieListParam params) async {
    final movieResult = switch (params.category) {
      MovieListCategories.nowPlaying =>
        await movieRepository.getNowPlaying(page: params.page),
      MovieListCategories.upcoming =>
        await movieRepository.getUpcoming(page: params.page),
    };

    return switch (movieResult) {
      Success(value: final movies) => Result.success(movies),
      Failed(:final message) => Result.failed(message)
    };
  }
}
