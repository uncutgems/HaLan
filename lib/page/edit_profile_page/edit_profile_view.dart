import 'dart:io';

import 'package:avwidget/av_alert_dialog_widget.dart';
import 'package:avwidget/av_button_widget.dart';
import 'package:avwidget/testing_tff.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/main.dart';
import 'package:halan/page/edit_profile_page/edit_profile_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey userInfoValidator = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  EditProfileBloc editProfileBloc = EditProfileBloc();

  File _image;

  @override
  void initState() {
    super.initState();
    EditProfileInitial();
    nameController.text = prefs.getString(Constant.fullName);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      cubit: editProfileBloc,
      builder: (BuildContext context, EditProfileState state) {
        if (state is EditProfileInitial) {
          return body(context);
        }
        if (state is CameraEditProfileState) {
          return body(context);
        }
        if (state is GalleryEditProfileState) {
          return body(context);
        }
        return Container();
      },
      buildWhen: (EditProfileState previous, EditProfileState current) {
        if (current is CameraOrGalleryEditProfileState) {
          _showPicker(context);
          return false;
        }
        if (current is FailToUploadEditProfileState) {
          _catchError(context, current.error);
          return false;
        }
        if (current is LoadingEditProfileState) {
          print('hello its me');
          showDialog<dynamic>(
              context: context,
              builder: (BuildContext context) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
          return false;
        }
        if (current is MakeChangeEditProfileState) {
          if (previous is LoadingEditProfileState) {
            Navigator.pop(context);
          }
          Navigator.pop(context, true);
          return false;
        }
        return true;
      },
    );
  }

  // Container(
  // alignment: Alignment.topCenter,
  // padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
  // color: const Color(0xffE5E5E5),
  // child:
  Widget body(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          backgroundColor: HaLanColor.backgroundColor,
          appBar: AppBar(
            title: const Text(
              'Thông tin cá nhân',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Container(
            alignment: Alignment.topCenter,
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
            color: const Color(0xffE5E5E5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 Stack(
                   alignment: Alignment.center,
                    children: <Widget>[
                      if (_image == null)
                        CircleAvatar(radius: 40,
                            backgroundImage:
                                NetworkImage(prefs.getString(Constant.avatar)))
                      else
                        CircleAvatar(radius: 40,backgroundImage: FileImage(_image)),
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: HaLanColor.gray80.withOpacity(0.8),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.camera_alt),
                        color: HaLanColor.white,
                        onPressed: () {
                          editProfileBloc.add(ChangeAvatarEditProfileEvent());
                        },
                      ),
                    ],
                  ),
                HalanTextFormField(
                  title: 'Tên',
                  keyboardType: TextInputType.text,
                  textEditingController: nameController,
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
              height: 48,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
              decoration: BoxDecoration(
                color: HaLanColor.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: RaisedButton(
                onPressed: () {
                  if (_image != null) {
                    editProfileBloc.add(ClickSaveChangeEditProfileEvent(
                        fullName: nameController.text, image: _image));
                  } else {
                    editProfileBloc.add(ClickSaveChangeEditProfileEvent(
                        fullName: nameController.text));
                  }
                  // Navigator.pop(context);
                },
                child: const Text(
                  'Lưu thay đổi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: HaLanColor.white,
                  ),
                ),
              )),
        ));
  }

  Future<void> _imageFromCamera() async {
    PickedFile file = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);
    File image = File(file.path);
    _image = image;
    editProfileBloc.add(TakePictureEditProfileEvent(_image));
  }

  Future<void> _imageFromGallery() async {
    PickedFile file = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    File image = File(file.path);
    _image = image;
    editProfileBloc.add(ChooseExistingImageEditProfileEvent(_image));
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Thư viện'),
                      onTap: () {
                        _imageFromGallery();
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Máy ảnh'),
                    onTap: () {
                      _imageFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _catchError(BuildContext context, String error) {
    showDialog<dynamic>(
        context: context,
        builder: (BuildContext context) {
          return AVAlertDialogWidget(
            title: 'Lỗi khi cập nhật thông tin',
            context: context,
            content: 'Không thể cập nhật thông tin vì $error',
            bottomWidget: Center(
              child: AVButton(
                color: HaLanColor.primaryColor,
                title: 'Thử lại?',
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(RoutesName.homeSignInPage));
                },
              ),
            ),
          );
        });
  }
}
