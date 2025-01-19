import 'package:warung_bioskop/data/repositories/auth_repository.dart';
import 'package:warung_bioskop/data/repositories/user_repository.dart';
import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/domain/entities/user.dart';
import 'package:warung_bioskop/domain/usecases/register/register_params.dart';
import 'package:warung_bioskop/domain/usecases/usecase.dart';

class RegisterUsecase implements UseCase<Result<User>, RegisterParams> {
  final UserRepository userRepository;
  final AuthRepository authRepository;

  RegisterUsecase({required UserRepository user, required AuthRepository auth})
      : userRepository = user,
        authRepository = auth;

  @override
  Future<Result<User>> call(RegisterParams params) async {
    final uidResult = await authRepository.register(
        email: params.email, password: params.password);

    if (uidResult.isSuccess) {
      final result = await userRepository.createUser(
          uid: uidResult.errorMessage!, email: params.email, name: params.name);

      if (result.isSuccess) {
        return Result.success(result.resultValue!);
      } else {
        return Result.failed(result.errorMessage!);
      }
    } else {
      return Result.failed(uidResult.errorMessage!);
    }
  }
}
