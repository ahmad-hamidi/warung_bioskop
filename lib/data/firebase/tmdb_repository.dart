import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:warung_bioskop/data/repositories/movie_repository.dart';
import 'package:warung_bioskop/domain/entities/movie.dart';
import 'package:warung_bioskop/domain/entities/movie_detail.dart';
import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/presentation/misc/AESHelper.dart';

class TmdbRepository implements MovieRepository {
  final Dio? dio;
  final String accessToken =
      Aeshelper().decryptText('${dotenv.env['TMBD_TOKEN']}');

  TmdbRepository({Dio? d}) : dio = d ?? Dio();

  @override
  Future<Result<MovieDetail>> getActors({required int id}) {
    // TODO: implement getActors
    throw UnimplementedError();
  }

  @override
  Future<Result<MovieDetail>> getDetail({required int id}) {
    // TODO: implement getDetail
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Movie>>> getNowPlaying({int page = 1}) {
    // TODO: implement getNowPlaying
    throw UnimplementedError();
  }

  @override
  Future<Result<List<Movie>>> getUpcoming({int page = 1}) {
    // TODO: implement getUpcoming
    throw UnimplementedError();
  }
}
