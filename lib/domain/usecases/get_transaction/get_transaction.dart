import 'package:warung_bioskop/data/repositories/transaction_repository.dart';
import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/domain/entities/transaction.dart';
import 'package:warung_bioskop/domain/usecases/get_transaction/get_transaction_param.dart';
import 'package:warung_bioskop/domain/usecases/usecase.dart';

class GetTransaction
    implements UseCase<Result<List<Transaction>>, GetTransactionParam> {
  final TransactionRepository transactionRepository;

  GetTransaction({required TransactionRepository repo})
      : transactionRepository = repo;

  @override
  Future<Result<List<Transaction>>> call(GetTransactionParam params) async {
    final result =
        await transactionRepository.getUserTransaction(uid: params.userId);
    return switch (result) {
      Success(value: final list) => Result.success(list),
      Failed(:final message) => Result.failed(message)
    };
  }
}
