import 'package:warung_bioskop/data/repositories/auth_repository.dart';
import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/domain/usecases/usecase.dart';

class LogoutUsecase implements UseCase<Result<void>, void> {
  final AuthRepository authtentication;

  LogoutUsecase({required AuthRepository auth}) : authtentication = auth;

  @override
  Future<Result<void>> call(void params) async {
    final result = await authtentication.logout();
    if (result.errorMessage != null) {
      return Result.failed(result.errorMessage!);
    } else {
      return const Result.success(null);
    }
  }
}
