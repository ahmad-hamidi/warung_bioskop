import 'package:warung_bioskop/data/repositories/user_repository.dart';
import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/domain/entities/user.dart';
import 'package:warung_bioskop/domain/usecases/upload_profile_picture/upload_profile_picture_param.dart';
import 'package:warung_bioskop/domain/usecases/usecase.dart';

class UploadProfilePicture
    implements UseCase<Result<User>, UploadProfilePictureParam> {
  final UserRepository userRepository;

  UploadProfilePicture({required UserRepository repo}) : userRepository = repo;

  @override
  Future<Result<User>> call(UploadProfilePictureParam params) => userRepository
      .uploadProfilePicture(user: params.user, imageFile: params.imageFile);
}
