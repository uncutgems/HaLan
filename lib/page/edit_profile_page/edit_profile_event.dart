part of 'edit_profile_bloc.dart';

@immutable
abstract class EditProfileEvent {}

class ChangeAvatarEditProfileEvent extends EditProfileEvent{}

class ChooseExistingImageEditProfileEvent extends EditProfileEvent{
  ChooseExistingImageEditProfileEvent(this.image);

  final File image;
}

class TakePictureEditProfileEvent extends EditProfileEvent{
  TakePictureEditProfileEvent(this.image);

  final File image;
}

class ClickSaveChangeEditProfileEvent extends EditProfileEvent{
  ClickSaveChangeEditProfileEvent({this.image, this.fullName,});

  final File image;
  final String fullName;
}
