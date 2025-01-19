import 'package:warung_bioskop/data/repositories/movie_repository.dart';
import 'package:warung_bioskop/domain/entities/actor.dart';
import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/domain/usecases/get_actors/get_actors_param.dart';
import 'package:warung_bioskop/domain/usecases/usecase.dart';

class GetActors implements UseCase<Result<List<Actor>>, GetActorsParam> {
  final MovieRepository movieRepository;

  GetActors({required MovieRepository repo}) : movieRepository = repo;

  @override
  Future<Result<List<Actor>>> call(GetActorsParam params) async {
    final result = await movieRepository.getActors(id: params.movieId);
    if (result.isSuccess) {
      return Result.success(result.resultValue ?? []);
    } else {
      return Result.failed(result.errorMessage ?? 'Failed to Get Actors');
    }
  }
}
