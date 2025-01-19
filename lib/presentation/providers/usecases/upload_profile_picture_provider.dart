import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:warung_bioskop/domain/usecases/upload_profile_picture/upload_profile_picture.dart';

import 'package:warung_bioskop/presentation/providers/repositories/user_repository/user_repository_provider.dart';

part 'upload_profile_picture_provider.g.dart';

@riverpod
UploadProfilePicture uploadProfilePicture(UploadProfilePictureRef ref) =>
    UploadProfilePicture(repo: ref.watch(userRepositoryProvider));
