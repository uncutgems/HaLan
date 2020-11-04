import 'dart:io';
import 'package:avwidget/popup_loading_widget.dart';
import 'package:avwidget/size_tool.dart';
import 'package:avwidget/testing_tff.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/base/tools.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/size.dart';
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
    print(nameController.text);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditProfileBloc, EditProfileState>(
      cubit: editProfileBloc,
      builder: (BuildContext context, EditProfileState state) {
        if (state is EditProfileInitial) {
          return _body(context);
        }
        if (state is CameraEditProfileState) {
          return _body(context);
        }
        if (state is GalleryEditProfileState) {
          return _body(context);
        }
        return Container();
      },
      buildWhen: (EditProfileState previous, EditProfileState current) {
        if (current is CameraOrGalleryEditProfileState) {
          _showPicker(context);
          return false;
        }
        if (current is FailToUploadEditProfileState &&
            previous is LoadingEditProfileState) {
          Navigator.pop(context);
          showMessage(context: context, message: current.error);
          return false;
        }
        if (current is LoadingEditProfileState) {
          showPopupLoading(context);
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

  Widget _body(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          print('detect duoc rui nhe');
        },
        child: Scaffold(
          backgroundColor: HaLanColor.backgroundColor,
          appBar: AppBar(
            title: Text('Thông tin cá nhân',
                style: textTheme.subtitle1
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 18)),
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
            padding: EdgeInsets.fromLTRB(AVSize.getSize(context, 16),
                AVSize.getSize(context, 24), AVSize.getSize(context, 16), 0),
            color: HaLanColor.backgroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    if (_image == null)
                      CircleAvatar(
                          radius: AVSize.getSize(context, 40),
                          backgroundImage:
                              NetworkImage(prefs.getString(Constant.avatar)))
                    else
                      CircleAvatar(
                          radius: AVSize.getSize(context, 40),
                          backgroundImage: FileImage(_image)),
                    Container(
                      width: AVSize.getSize(context, 80),
                      height: AVSize.getSize(context, 80),
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
                Container(
                  height: AVSize.getSize(context, 25),
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
              height: AVSize.getSize(context, 48),
              margin: EdgeInsets.fromLTRB(AVSize.getSize(context, 16), 0,
                  AVSize.getSize(context, 16), AVSize.getSize(context, 24)),
              decoration: BoxDecoration(
                color: HaLanColor.primaryColor,
                borderRadius: BorderRadius.circular(AVSize.getSize(context, 8)),
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
                child: Text(
                  'Lưu thay đổi',
                  style:
                      textTheme.subtitle1.copyWith(fontWeight: FontWeight.w500),
                ),
              )),
        ));
  }

  Future<void> _imageFromCamera() async {
    final PickedFile file = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);
    final File image = File(file.path);
    _image = image;
    editProfileBloc.add(TakePictureEditProfileEvent(_image));
  }

  Future<void> _imageFromGallery() async {
    final PickedFile file = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    final File image = File(file.path);
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
                height: AppSize.getWidth(context, 40),
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
