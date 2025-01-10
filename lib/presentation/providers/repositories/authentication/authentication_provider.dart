import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warung_bioskop/data/firebase/firebase_auth_repository.dart';
import 'package:warung_bioskop/data/repositories/auth_repository.dart';

part 'authentication_provider.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) =>
    FirebaseAuthRepository();
