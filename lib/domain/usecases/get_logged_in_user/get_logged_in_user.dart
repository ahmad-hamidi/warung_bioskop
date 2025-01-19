import 'package:warung_bioskop/data/repositories/auth_repository.dart';
import 'package:warung_bioskop/data/repositories/user_repository.dart';
import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/domain/entities/user.dart';

import 'package:warung_bioskop/domain/usecases/usecase.dart';

class GetLoggedInUser implements UseCase<Result<User>, void> {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  GetLoggedInUser({required AuthRepository auth, required UserRepository user})
      : authRepository = auth,
        userRepository = user;

  @override
  Future<Result<User>> call(void params) async {
    final String? loggedId = authRepository.getLoggedInUserId();
    if (loggedId != null) {
      final model = await userRepository.getUser(uid: loggedId);
      if (model?.isSuccess == true && model?.resultValue != null) {
        return Result.success(model!.resultValue!);
      } else {
        return Result.failed(model?.errorMessage ?? 'No user logged in');
      }
    } else {
      return const Result.failed('No user logged in');
    }
  }
}
