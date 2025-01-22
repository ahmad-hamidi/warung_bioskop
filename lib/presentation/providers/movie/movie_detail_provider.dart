import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warung_bioskop/domain/entities/movie.dart';
import 'package:warung_bioskop/domain/entities/movie_detail.dart';
import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/domain/usecases/get_movie_detail/get_movie_detail_params.dart';
import 'package:warung_bioskop/domain/usecases/get_movie_detail/get_movie_detail_usecase.dart';
import 'package:warung_bioskop/presentation/providers/usecases/get_movie_detail_provider.dart';

part 'movie_detail_provider.g.dart';

@riverpod
Future<MovieDetail?> movieDetail(MovieDetailRef ref,
    {required Movie movie}) async {
  GetMovieDetailUsecase usecase = ref.read(getMovieDetailProvider);

  final result = await usecase(
    GetMovieDetailParams(movie: movie),
  );

  // if (result.isSuccess) {
  //   return result.resultValue;
  // } else {
  //   Result.failed(result.errorMessage ?? 'Failed to Get Movie Detail');
  // }

  return switch (result) {
    Success(value: final movieDetail) => movieDetail,
    Failed(message: _) => null
  };
}
