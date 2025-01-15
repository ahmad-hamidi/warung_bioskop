import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:warung_bioskop/data/firebase/firebase_user_repository.dart';
import 'package:warung_bioskop/data/repositories/transaction_repository.dart';
import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/domain/entities/transaction.dart';

class FirebaseTransactionRepository implements TransactionRepository {
  final firestore.FirebaseFirestore firebaseFirestore;

  FirebaseTransactionRepository({firestore.FirebaseFirestore? fs})
      : firebaseFirestore = fs ?? firestore.FirebaseFirestore.instance;

  @override
  Future<Result<Transaction>> createTransaction(
      {required Transaction transaction}) async {
    try {
      final userRepository =
          await FirebaseUserRepository().getUserBalance(uid: transaction.uid);

      if (!userRepository.isSuccess) {
        return const Result.failed("Failed to create transaction");
      }

      final previousBalance = userRepository.resultValue ?? 0;
      final currentBalance = previousBalance - transaction.total;
      if (currentBalance > 0) {
        final collection = firebaseFirestore.collection("transactions");
        await collection.doc(transaction.id).set(transaction.toJson());

        final result = await collection.doc(transaction.id).get();

        if (result.exists) {
          await FirebaseUserRepository()
              .updateUserBalance(uid: transaction.uid, balance: currentBalance);
          return Result.success(Transaction.fromJson(result.data()!));
        } else {
          return const Result.failed("Failed to create transaction");
        }
      }

      return const Result.failed("Insufficient balance");
    } catch (e) {
      return const Result.failed("Failed to create transaction");
    }
  }

  @override
  Future<Result<List<Transaction>>> getUserTransaction(
      {required String uid}) async {
    try {
      final collection = firebaseFirestore.collection("transactions");

      //final result = await collection.doc(uid).get();
      final result = await collection.where('uid', isEqualTo: uid).get();
      if (result.docs.isEmpty) {
        return const Result.failed("User transaction not found");
      }

      final list =
          result.docs.map((e) => Transaction.fromJson(e.data())).toList();
      return Result.success(list);
    } catch (e) {
      return const Result.failed("Failed to get user transaction");
    }
  }
}
