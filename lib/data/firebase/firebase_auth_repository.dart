import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:warung_bioskop/data/repositories/auth_repository.dart';
import 'package:warung_bioskop/domain/entities/result.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  FirebaseAuthRepository({FirebaseAuth? auth})
      : firebaseAuth = auth ?? FirebaseAuth.instance;

  @override
  String? getLoggedInUserId() => firebaseAuth.currentUser?.uid;

  @override
  Future<Result<String>> login(
      {required String email, required String password}) async {
    try {
      var userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final token = await userCredential.user?.getIdToken(true);
      debugPrint('cekx $token');
      return Result.success(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      return Result.failed(e.message ?? 'Failed login');
    }
  }

  @override
  Future<Result<void>> logout() async {
    await firebaseAuth.signOut();
    if (firebaseAuth.currentUser == null) {
      return const Result.success(null);
    } else {
      return const Result.failed('Failed to sign');
    }
  }

  @override
  Future<Result<String>> register(
      {required String email, required String password}) async {
    try {
      final result = await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (result.user?.uid != null) {
        debugPrint('x1');
        return Result.success(result.user!.uid);
      } else {
        debugPrint('x2');
        return const Result.success('Failed create new user');
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('x3');
      return Result.failed('${e.message}');
    }
  }
}
