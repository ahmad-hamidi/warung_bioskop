import 'package:warung_bioskop/data/repositories/auth_repository.dart';
import 'package:warung_bioskop/data/repositories/user_repository.dart';
import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/domain/entities/user.dart';
import 'package:warung_bioskop/domain/usecases/login/login_params.dart';
import 'package:warung_bioskop/domain/usecases/usecase.dart';

class LoginUsecase implements UseCase<Result<User>, LoginParams> {

  final AuthRepository authRepository;
  final UserRepository userRepository;

  LoginUsecase({required this.authRepository, required this.userRepository});
  
  @override
  Future<Result<User>> call(LoginParams params) async {
    final loginResult = await authRepository.login(email: params.email, password: params.password);
    if (loginResult is Success) {
      final userResult = await userRepository.getUser(uid: loginResult.resultValue!);
      
      // return switch (userResult) {
      //  Success value => Result.success(value.resultValue!),
      //  Failed value => Result.failed(value.errorMessage!),
      //  null => const Result.failed("No result"),
      // };

      return switch (userResult) {
       Success(value: final user) => Result.success(user),
       Failed(: final message) => Result.failed(message),
       null => const Result.failed("No result"),
      };
    } else {
      return Result.failed(loginResult.errorMessage!);
    }
  }

}
