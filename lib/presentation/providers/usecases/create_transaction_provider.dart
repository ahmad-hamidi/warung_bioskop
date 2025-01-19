import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warung_bioskop/domain/usecases/create_transaction/create_transaction.dart';

import 'package:warung_bioskop/presentation/providers/repositories/transaction_repository/transaction_repository.dart';

part 'create_transaction_provider.g.dart';

@riverpod
CreateTransaction createTransaction(CreateTransactionRef ref) =>
    CreateTransaction(
      repo: ref.watch(transactionRepositoryProvider),
    );
