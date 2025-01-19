import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warung_bioskop/domain/usecases/get_actors/get_actors.dart';

import 'package:warung_bioskop/presentation/providers/repositories/movie_repository/movie_repository_provider.dart';

part 'get_actors_provider.g.dart';

@riverpod
GetActors getActors(GetActorsRef ref) => GetActors(
      repo: ref.watch(movieRepositoryProvider),
    );
