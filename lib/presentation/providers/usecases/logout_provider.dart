import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warung_bioskop/domain/usecases/logout/logout_usecase.dart';
import 'package:warung_bioskop/presentation/providers/repositories/authentication/authentication_provider.dart';

part 'logout_provider.g.dart';

@riverpod
LogoutUsecase logout(LogoutRef ref) => LogoutUsecase(
      auth: ref.watch(authRepositoryProvider),
    );
