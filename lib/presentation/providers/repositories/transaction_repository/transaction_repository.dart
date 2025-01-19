import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warung_bioskop/data/firebase/firebase_transaction_repository.dart';
import 'package:warung_bioskop/data/repositories/transaction_repository.dart';

part 'transaction_repository.g.dart';

@riverpod
TransactionRepository transactionRepository(TransactionRepositoryRef ref) =>
    FirebaseTransactionRepository();
