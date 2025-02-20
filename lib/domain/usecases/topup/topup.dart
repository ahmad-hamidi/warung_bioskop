import 'package:warung_bioskop/data/repositories/transaction_repository.dart';

import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/domain/entities/transaction.dart';
import 'package:warung_bioskop/domain/usecases/create_transaction/create_transaction.dart';
import 'package:warung_bioskop/domain/usecases/create_transaction/create_transaction_param.dart';
import 'package:warung_bioskop/domain/usecases/topup/topup_param.dart';
import 'package:warung_bioskop/domain/usecases/usecase.dart';
import 'package:warung_bioskop/presentation/misc/constants.dart';

class Topup implements UseCase<Result<void>, TopupParam> {
  final TransactionRepository transactionRepository;

  Topup({required TransactionRepository transactionRepo})
      : transactionRepository = transactionRepo;

  @override
  Future<Result<void>> call(TopupParam params) async {
    //final result = await userRepository.updateUserBalance(
    //  uid: params.userId, balance: params.amount);

    final CreateTransaction usecase =
        CreateTransaction(repo: transactionRepository);

    final int currentTime = DateTime.now().millisecondsSinceEpoch;

    final createTransactionResult = await usecase(
      CreateTransactionParam(
        transaction: Transaction(
            id: 'flxtp-$currentTime-${params.userId}',
            uid: params.userId,
            title: topupKey,
            adminFee: 0,
            total: -params.amount,
            transactionTime: currentTime),
      ),
    );

    if (createTransactionResult.isSuccess) {
      return const Result.success(null);
    } else {
      return const Result.failed('Failed to top up');
    }
  }
}
