import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warung_bioskop/domain/usecases/login/login_usecase.dart';
import 'package:warung_bioskop/presentation/providers/repositories/authentication/authentication_provider.dart';
import 'package:warung_bioskop/presentation/providers/repositories/user_repository/user_repository_provider.dart';

part 'login_provider.g.dart';

@riverpod
LoginUsecase login(LoginRef ref) => LoginUsecase(
    authRepository: ref.watch(authRepositoryProvider),
    userRepository: ref.watch(userRepositoryProvider));
