import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/domain/entities/user.dart';
import 'package:warung_bioskop/domain/usecases/get_logged_in_user/get_logged_in_user.dart';
import 'package:warung_bioskop/domain/usecases/login/login_params.dart';
import 'package:warung_bioskop/domain/usecases/login/login_usecase.dart';
import 'package:warung_bioskop/domain/usecases/register/register_params.dart';
import 'package:warung_bioskop/domain/usecases/register/register_usecase.dart';
import 'package:warung_bioskop/domain/usecases/topup/topup.dart';
import 'package:warung_bioskop/domain/usecases/topup/topup_param.dart';
import 'package:warung_bioskop/domain/usecases/upload_profile_picture/upload_profile_picture.dart';
import 'package:warung_bioskop/domain/usecases/upload_profile_picture/upload_profile_picture_param.dart';
import 'package:warung_bioskop/presentation/providers/movie/now_playing_provider.dart';
import 'package:warung_bioskop/presentation/providers/movie/upcoming_provider.dart';
import 'package:warung_bioskop/presentation/providers/usecases/get_logged_in_user_provider.dart';
import 'package:warung_bioskop/presentation/providers/usecases/login_provider.dart';
import 'package:warung_bioskop/presentation/providers/usecases/logout_provider.dart';
import 'package:warung_bioskop/presentation/providers/usecases/register_provider.dart';
import 'package:warung_bioskop/presentation/providers/usecases/topup_provider.dart';
import 'package:warung_bioskop/presentation/providers/usecases/upload_profile_picture_provider.dart';

part 'user_data_provider.g.dart';

@Riverpod(keepAlive: true)
class UserData extends _$UserData {
  @override
  Future<User?> build() async {
    final GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);
    final userResult = await getLoggedInUser(null);

    switch (userResult) {
      case Success(value: final user):
        _getMovies();
        return user;
      case Failed(message: _):
        return null;
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    LoginUsecase login = ref.read(loginProvider);
    final result = await login(
      LoginParams(email: email, password: password),
    );

    switch (result) {
      case Success(value: final user):
        _getMovies();
        state = AsyncData(user);

      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String name,
    String? imageUrl,
  }) async {
    state = const AsyncLoading();
    RegisterUsecase register = ref.read(registerProvider);
    final result = await register(
      RegisterParams(
          email: email, password: password, name: name, photoUrl: imageUrl),
    );

    switch (result) {
      case Success(value: final user):
        _getMovies();
        state = AsyncData(user);

      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = const AsyncData(null);
    }
  }

  Future<void> refreshUserData() async {
    final GetLoggedInUser getLoggedInUser = ref.read(getLoggedInUserProvider);
    final result = await getLoggedInUser(null);
    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  Future<void> logout() async {
    final logout = ref.read(logoutProvider);
    final result = await logout(null);
    switch (result) {
      case Success(value: _):
        state = const AsyncData(null);
      case Failed(:final message):
        state = AsyncError(FlutterError(message), StackTrace.current);
        state = AsyncData(state.valueOrNull);
    }
  }

  Future<void> topUp(int amount) async {
    final Topup topup = ref.read(topupProvider);
    final userId = state.valueOrNull?.uid;

    if (userId != null) {
      final result = await topup(TopupParam(amount: amount, userId: userId));

      if (result.isSuccess) {
        refreshUserData();
        // TODO: refresh transaction date
      }
    }
  }

  Future<void> uploadProfilePicture(
      {required User user, required File file}) async {
    final UploadProfilePicture uploadProfilePicture =
        ref.read(uploadProfilePictureProvider);

    final result = await uploadProfilePicture(
      UploadProfilePictureParam(imageFile: file, user: user),
    );

    if (result case Success(value: final user)) {
      state = AsyncData(user);
    }
  }

  void _getMovies() {
    ref.read(nowPlayingProviderProvider.notifier).getMovies();
    ref.read(upcomingProviderProvider.notifier).getMovies();
  }
}
