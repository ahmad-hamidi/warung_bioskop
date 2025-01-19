import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warung_bioskop/domain/usecases/get_logged_in_user/get_logged_in_user.dart';
import 'package:warung_bioskop/presentation/providers/repositories/authentication/authentication_provider.dart';
import 'package:warung_bioskop/presentation/providers/repositories/user_repository/user_repository_provider.dart';

part 'get_logged_in_user_provider.g.dart';

@riverpod
GetLoggedInUser getLoggedInUser(GetLoggedInUserRef ref) => GetLoggedInUser(
      auth: ref.watch(authRepositoryProvider),
      user: ref.watch(userRepositoryProvider),
    );
