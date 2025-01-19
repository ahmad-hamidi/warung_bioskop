import 'package:warung_bioskop/data/repositories/transaction_repository.dart';
import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/domain/usecases/create_transaction/create_transaction_param.dart';
import 'package:warung_bioskop/domain/usecases/usecase.dart';

class CreateTransaction
    implements UseCase<Result<void>, CreateTransactionParam> {
  final TransactionRepository transactionRepository;

  CreateTransaction({required TransactionRepository repo})
      : transactionRepository = repo;

  @override
  Future<Result<void>> call(CreateTransactionParam params) async {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final result = await transactionRepository.createTransaction(
      transaction: params.transaction.copyWith(
        transactionTime: currentTime,
        id: (params.transaction.id == null)
            ? 'flx-$currentTime-${params.transaction.uid}'
            : params.transaction.id,
      ),
    );

    if (result.isSuccess) {
      return const Result.success(null);
    } else {
      return Result.failed(
          result.errorMessage ?? 'Failed to Create Transaction');
    }
  }
}
