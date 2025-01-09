import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:warung_bioskop/data/repositories/user_repository.dart';
import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/domain/entities/user.dart';

class FirebaseUserRepository implements UserRepository {
  final FirebaseFirestore firebaseFirestore;

  FirebaseUserRepository({FirebaseFirestore? store})
      : firebaseFirestore = store ?? FirebaseFirestore.instance;

  @override
  Future<Result<User>> createUser(
      {required String uid,
      required String email,
      required String name,
      String? photoUrl,
      int balance = 0}) {
    // TODO: implement createUser
    throw UnimplementedError();
  }

  @override
  Future<Result<User>>? getUser({required String uid}) async {
    final store = firebaseFirestore.doc("user/$uid");
    final doc = await store.get();
    if (doc.exists == true) {
      return Result.success(User.fromJson(doc.data()!));
    } else {
      return const Result.failed("User not found");
    }
  }

  @override
  Future<Result<int>> getUserBalance({required String uid}) {
    // TODO: implement getUserBalance
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateUser({required User user}) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> updateUserBalance(
      {required String uid, required int balance}) {
    // TODO: implement updateUserBalance
    throw UnimplementedError();
  }

  @override
  Future<Result<User>> uploadProfilePicture(
      {required User user, required File imageFile}) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }
}
