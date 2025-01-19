import 'package:warung_bioskop/data/repositories/user_repository.dart';
import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/domain/usecases/get_user_balance/get_user_balance_param.dart';
import 'package:warung_bioskop/domain/usecases/usecase.dart';

class GetUserBalance implements UseCase<Result<int>, GetUserBalanceParam> {
  final UserRepository userRepository;

  GetUserBalance({required UserRepository repo}) : userRepository = repo;

  @override
  Future<Result<int>> call(GetUserBalanceParam params) async {
    return await userRepository.getUserBalance(uid: params.userId);
  }
}
