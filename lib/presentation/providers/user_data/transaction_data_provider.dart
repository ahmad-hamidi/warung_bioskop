import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warung_bioskop/domain/entities/result.dart';

import 'package:warung_bioskop/domain/entities/transaction.dart';
import 'package:warung_bioskop/domain/entities/user.dart';
import 'package:warung_bioskop/domain/usecases/get_transaction/get_transaction.dart';
import 'package:warung_bioskop/domain/usecases/get_transaction/get_transaction_param.dart';
import 'package:warung_bioskop/presentation/providers/usecases/get_transaction_provider.dart';
import 'package:warung_bioskop/presentation/providers/user_data/user_data_provider.dart';

part 'transaction_data_provider.g.dart';

@Riverpod(keepAlive: true)
class TransactionData extends _$TransactionData {
  @override
  Future<List<Transaction>> build() async {
    final User? user = ref.read(userDataProvider).valueOrNull;
    if (user != null) {
      state = const AsyncLoading();

      final GetTransaction getTransaction = ref.read(getTransactionProvider);
      final result = await getTransaction(
        GetTransactionParam(userId: user.uid),
      );

      // if (result.isSuccess) {
      //   return result.resultValue!;
      // }

      if (result case Success(value: final transactions)) {
        return transactions;
      }
    }
    return [];
  }

  Future<void> refreshTransactionData() async {
    final User? user = ref.read(userDataProvider).valueOrNull;
    if (user != null) {
      state = const AsyncLoading();

      final GetTransaction getTransaction = ref.read(getTransactionProvider);
      final result =
          await getTransaction(GetTransactionParam(userId: user.uid));

      switch (result) {
        case Success(value: final transaction):
          state = AsyncData(transaction);
        case Failed(:final message):
          state = AsyncError(message, StackTrace.current);
          state = AsyncData(state.valueOrNull ?? const []);
      }
    }
  }
}
