import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:hive/hive.dart';

import 'package:warung_bioskop/data/repositories/movie_repository.dart';
import 'package:warung_bioskop/domain/entities/actor.dart';
import 'package:warung_bioskop/domain/entities/movie.dart';
import 'package:warung_bioskop/domain/entities/movie_detail.dart';
import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/main.dart';
import 'package:warung_bioskop/presentation/misc/AESHelper.dart';
import 'package:warung_bioskop/presentation/misc/constants.dart';

class TmdbRepository implements MovieRepository {
  final Dio? dio;

  TmdbRepository({Dio? d}) : dio = d ?? Dio();

  void setDioProxy() {
    // (dio?.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
    //   final HttpClient client = HttpClient();
    //   client.findProxy = (uri) {
    //     return "PROXY xxx.xxx.xxx:8888;";
    //   };
    //   return client;
    // };
  }

  Future<Options> getOptions() async {
    Uint8List key = padKeyTo32Bytes(shortKey);

    Uint8List secret = base64Decode(base64Encode(key));

    var encryptedBox =
        await Hive.openBox(keyBox, encryptionCipher: HiveAesCipher(secret));

    return Options(headers: {
      'Authorization':
          'Bearer ${Aeshelper(ivKey: encryptedBox.get(ivKey), aesKey: encryptedBox.get(encryptionKey)).decryptText(encryptedBox.get(tmdbToken))}',
      'accept': 'application/json'
    });
  }

  @override
  Future<Result<List<Actor>>> getActors({required int id}) async {
    try {
      setDioProxy();
      final options = await getOptions();
      final response = await dio?.get(
          'https://api.themoviedb.org/3/movie/$id/credits',
          options: options);

      if (response?.statusCode == 200) {
        final list = List<Map<String, dynamic>>.from(response!.data['cast']);
        return Result.success(list.map((e) => Actor.fromJSON(e)).toList());
      } else {
        return const Result.failed('Failed GET Movie');
      }
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  @override
  Future<Result<MovieDetail>> getDetail({required int id}) async {
    try {
      setDioProxy();
      final options = await getOptions();
      final response = await dio?.get('https://api.themoviedb.org/3/movie/$id',
          options: options);

      if (response?.statusCode == 200) {
        return Result.success(MovieDetail.fromJSON(response!.data));
      } else {
        return const Result.failed('Failed GET Detail');
      }
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }

  @override
  Future<Result<List<Movie>>> getNowPlaying({int page = 1}) async =>
      _getMovies(_MovieCategory.nowPlaying.toString(), page: page);

  @override
  Future<Result<List<Movie>>> getUpcoming({int page = 1}) async =>
      _getMovies(_MovieCategory.upcoming.toString(), page: page);

  Future<Result<List<Movie>>> _getMovies(String category,
      {int page = 1}) async {
    try {
      setDioProxy();
      final options = await getOptions();
      final response = await dio?.get(
          'https://api.themoviedb.org/3/movie/$category?page=$page',
          options: options);

      if (response?.statusCode == 200) {
        final list = List<Map<String, dynamic>>.from(response!.data['results']);
        return Result.success(list.map((e) => Movie.fromJSON(e)).toList());
      } else {
        return const Result.failed('Failed GET Movie');
      }
    } on DioException catch (e) {
      return Result.failed('${e.message}');
    }
  }
}

enum _MovieCategory {
  nowPlaying('now_playing'),
  upcoming('upcoming');

  final String string;

  const _MovieCategory(String instring) : string = instring;

  @override
  String toString() => string;
}
