import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warung_bioskop/domain/entities/actor.dart';

import 'package:warung_bioskop/domain/usecases/get_actors/get_actors.dart';
import 'package:warung_bioskop/domain/usecases/get_actors/get_actors_param.dart';
import 'package:warung_bioskop/presentation/providers/usecases/get_actors_provider.dart';

part 'actors_provider.g.dart';

@riverpod
Future<List<Actor>> actors(ActorsRef ref, {required int movieId}) async {
  GetActors usecase = ref.read(getActorsProvider);

  final result = await usecase(
    GetActorsParam(movieId: movieId),
  );

  if (result.isSuccess) {
    return result.resultValue!;
  } else {
    return [];
  }
}
