part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}

class MakeChangeEditProfileState extends EditProfileState{
  MakeChangeEditProfileState({this.image, this.fullName});
  final File image;
  final String fullName;
}

class CameraOrGalleryEditProfileState extends EditProfileState{}

class GalleryEditProfileState extends EditProfileState{
  GalleryEditProfileState(this.image);

  final File image;
}

class CameraEditProfileState extends EditProfileState{
  CameraEditProfileState(this.image);

  final File image;
}


class LoadingEditProfileState extends EditProfileState{}

class FailToUploadEditProfileState extends EditProfileState{
  FailToUploadEditProfileState(this.error);

  final String error;
}