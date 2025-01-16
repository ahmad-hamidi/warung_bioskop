import 'package:warung_bioskop/domain/entities/actor.dart';
import 'package:warung_bioskop/domain/entities/movie.dart';
import 'package:warung_bioskop/domain/entities/movie_detail.dart';
import 'package:warung_bioskop/domain/entities/result.dart';

abstract interface class MovieRepository {
  Future<Result<List<Movie>>> getNowPlaying({int page = 1});

  Future<Result<List<Movie>>> getUpcoming({int page = 1});

  Future<Result<MovieDetail>> getDetail({required int id});

  Future<Result<List<Actor>>> getActors({required int id});
}
