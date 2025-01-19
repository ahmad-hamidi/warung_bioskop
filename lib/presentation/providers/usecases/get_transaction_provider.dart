import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:warung_bioskop/domain/usecases/get_transaction/get_transaction.dart';

import 'package:warung_bioskop/presentation/providers/repositories/transaction_repository/transaction_repository.dart';

part 'get_transaction_provider.g.dart';

@riverpod
GetTransaction getTransaction(GetTransactionRef ref) => GetTransaction(
      repo: ref.watch(transactionRepositoryProvider),
    );
