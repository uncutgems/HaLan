import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:halan/base/api_handler.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/main.dart';
import 'package:halan/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'edit_profile_event.dart';

part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial());

  UserRepository userRepository = UserRepository();

  @override
  Stream<EditProfileState> mapEventToState(
    EditProfileEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is ClickSaveChangeEditProfileEvent) {
      try {
        userRepository.updateUserInfo(
            prefs.getString(Constant.id),
            event.fullName,
            prefs.getString(Constant.phoneNumber),
            await userRepository.uploadImageUrl(event.image));
        yield MakeChangeEditProfileState(
            fullName: event.fullName,
            image: event.image);
      } on APIException catch (e) {
        yield FailToUploadEditProfileState(e.message());
      }
    }
    if (event is ChangeAvatarEditProfileEvent) {
      yield CameraOrGalleryEditProfileState();
    }
    if (event is TakePictureEditProfileEvent){
      yield CameraEditProfileState(event.image);
    }
    if (event is ChooseExistingImageEditProfileEvent){
      yield GalleryEditProfileState(event.image);
    }
  }
}
