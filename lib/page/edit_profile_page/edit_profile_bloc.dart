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
        yield LoadingEditProfileState();
        if (event.image != null) {
          await userRepository.updateUserInfo(
              prefs.getString(Constant.userId),
              event.fullName,
              prefs.getString(Constant.phoneNumber),
              imageURL: await userRepository.uploadImageUrl(event.image));
          yield MakeChangeEditProfileState(
              fullName: event.fullName, image: event.image);
        }
        else{
          await userRepository.updateUserInfo(prefs.getString(Constant.userId), event.fullName, prefs.getString(Constant.phoneNumber));
          yield MakeChangeEditProfileState(
              fullName: event.fullName);
        }
      } on APIException catch (e) {
        yield FailToUploadEditProfileState(e.message());
      } on Exception catch (e){
        yield FailToUploadEditProfileState('Không thể tải ảnh lên, vui lòng thử lại sau');
      }
    }
    if (event is ChangeAvatarEditProfileEvent) {
      yield CameraOrGalleryEditProfileState();
    }
    if (event is TakePictureEditProfileEvent) {
      yield CameraEditProfileState(event.image);
    }
    if (event is ChooseExistingImageEditProfileEvent) {
      yield GalleryEditProfileState(event.image);
    }
  }
}
