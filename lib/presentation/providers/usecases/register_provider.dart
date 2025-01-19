import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:warung_bioskop/domain/usecases/register/register_usecase.dart';
import 'package:warung_bioskop/presentation/providers/repositories/authentication/authentication_provider.dart';
import 'package:warung_bioskop/presentation/providers/repositories/user_repository/user_repository_provider.dart';

part 'register_provider.g.dart';

@riverpod
RegisterUsecase register(RegisterRef ref) => RegisterUsecase(
      auth: ref.watch(authRepositoryProvider),
      user: ref.watch(userRepositoryProvider),
    );
