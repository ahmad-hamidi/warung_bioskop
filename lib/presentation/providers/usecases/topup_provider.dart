import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:warung_bioskop/domain/usecases/topup/topup.dart';
import 'package:warung_bioskop/presentation/providers/repositories/transaction_repository/transaction_repository.dart';

part 'topup_provider.g.dart';

@riverpod
Topup topup(TopupRef ref) =>
    Topup(transactionRepo: ref.watch(transactionRepositoryProvider));
