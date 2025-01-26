import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
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
      int balance = 0}) async {
    final users = firebaseFirestore.collection('users');
    await users.doc(uid).set({
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl,
      'balance': balance,
    });
    //final user = await users.doc(uid).get();
    final user = await firebaseFirestore.doc('users/$uid').get();
    if (user.exists == true) {
      return Result.success(User.fromJson(user.data()!));
    } else {
      return const Result.failed('Failed insert the new user');
    }
  }

  @override
  Future<Result<User>>? getUser({required String uid}) async {
    final store = firebaseFirestore.doc("users/$uid");
    final doc = await store.get();
    if (doc.exists == true) {
      return Result.success(User.fromJson(doc.data()!));
    } else {
      return const Result.failed("User not found");
    }
  }

  @override
  Future<Result<int>> getUserBalance({required String uid}) async {
    final doc = firebaseFirestore.doc('users/$uid');
    final result = await doc.get();

    if (result.exists) {
      return Result.success(result.data()!['balance']);
    } else {
      return const Result.failed("User not found");
    }
  }

  @override
  Future<Result<User>> updateUser({required User user}) async {
    try {
      final doc = firebaseFirestore.doc('users/${user.uid}');
      await doc.update(user.toJson());

      final result = await doc.get();
      if (result.exists) {
        final userUpdated = User.fromJson(result.data()!);
        if (userUpdated == user) {
          return Result.success(userUpdated);
        } else {
          return const Result.failed("Failed to update user");
        }
      } else {
        return const Result.failed("Failed to update user");
      }
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? "Failed to update user");
    }
  }

  @override
  Future<Result<User>> updateUserBalance(
      {required String uid, required int balance}) async {
    try {
      final doc = firebaseFirestore.doc('users/$uid');

      final result = await doc.get();

      if (!result.exists) {
        return const Result.failed("User not found");
      }

      await doc.update({'balance': balance});
      final updatedResult = await doc.get();

      if (!updatedResult.exists) {
        return const Result.failed("Failed to update user balance");
      }

      final userUpdated = User.fromJson(updatedResult.data()!);
      if (userUpdated.balance == balance) {
        return Result.success(userUpdated);
      }

      return const Result.failed("Failed to update user balance");
    } on FirebaseException catch (e) {
      return Result.failed(e.message ?? "Failed to update user balance");
    }
  }

  @override
  Future<Result<User>> uploadProfilePicture(
      {required User user, required File imageFile}) async {
    String filename = basename(imageFile.path);
    final reference = FirebaseStorage.instance.ref().child(filename);

    try {
      await reference.putFile(imageFile);
      String downloadUrl = await reference.getDownloadURL();
      final updateResult =
          await updateUser(user: user.copyWith(photoUrl: downloadUrl));

      if (updateResult.isSuccess) {
        return Result.success(updateResult.resultValue!);
      } else {
        return Result.failed(updateResult.errorMessage!);
      }
    } catch (e) {
      return const Result.failed("Failed to upload profile");
    }
  }
}
