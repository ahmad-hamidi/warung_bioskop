import 'package:warung_bioskop/data/repositories/movie_repository.dart';
import 'package:warung_bioskop/domain/entities/movie_detail.dart';
import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/domain/usecases/get_movie_detail/get_movie_detail_params.dart';
import 'package:warung_bioskop/domain/usecases/usecase.dart';

class GetMovieDetail
    implements UseCase<Result<MovieDetail>, GetMovieDetailParams> {
  final MovieRepository movieRepository;

  GetMovieDetail({required MovieRepository repo}) : movieRepository = repo;

  @override
  Future<Result<MovieDetail>> call(GetMovieDetailParams params) async {
    final detailResult = await movieRepository.getDetail(id: params.movie.id);
    return switch (detailResult) {
      Success<MovieDetail>() => Result.success(detailResult.value),
      Failed<MovieDetail>() => Result.failed(detailResult.message),
    };
  }
}
