import 'package:avwidget/size_tool.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/routes.dart';
import 'package:halan/base/size.dart';
import 'package:halan/base/styles.dart';
import 'package:halan/page/personal_profile/personal_profile_bloc.dart';

import '../../main.dart';

class PersonalProfile extends StatefulWidget {
  @override
  _PersonalProfileState createState() => _PersonalProfileState();
}

class _PersonalProfileState extends State<PersonalProfile> {
  PersonalProfileBloc personalProfileBloc = PersonalProfileBloc();

  @override
  void initState() {
    super.initState();
    PersonalProfileInitial();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileBloc, PersonalProfileState>(
      cubit: personalProfileBloc,
      builder: (BuildContext context, PersonalProfileState state) {
        if (state is PersonalProfileInitial) {
          return body(context);
        }
        else if (state is PersonalProfileUpdated) {
          print('updated');
          return body(context);
        }
        return Container();
      },
    );
  }

  Widget body(BuildContext context) {
    return Scaffold(
      backgroundColor: HaLanColor.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Thông tin cá nhân',),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: EdgeInsets.fromLTRB(AVSize.getSize(context, 16), AVSize.getSize(context, 24), AVSize.getSize(context, 16), 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            pictureAndName(prefs.getString(Constant.avatar),
                prefs.getString(Constant.fullName)),
            phoneNumber(prefs.getString(Constant.phoneNumber)),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.fromLTRB(AppSize.getWidth(context, 16), 0, AppSize.getWidth(context, 16), AppSize.getHeight(context, 16)),
        height: AppSize.getHeight(context, 48),
        child: RaisedButton(
          onPressed: (){
            prefs.clear();
            Navigator.pushNamed(context, RoutesName.busBookingPage);
          },
          color: HaLanColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AVSize.getSize(context, 8)),
          ),
          child: Text('Đăng xuất', style: textTheme.button),
        ),
      )
    );
  }

  Widget pictureAndName(String image, String fullName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Row(
            children: <Widget>[
              Container(
                width: AVSize.getSize(context, 80),
                height: AVSize.getSize(context, 80),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                width: AVSize.getSize(context, 16),
              ),
              Text(
                fullName,
                style: textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600, fontSize: 18)
                ),
            ],
          ),
        ),
        Container(
          height: AVSize.getSize(context, 32),
          width: AVSize.getSize(context, 32),
          child: IconButton(
            onPressed: () async {
              final bool refresh = await Navigator.pushNamed(context, RoutesName.editProfile) as bool;
              if(refresh) {
                print('assssssssssssssss');
                personalProfileBloc.add(CallAPIPersonalProfileEvent());
              }
            },
            icon: ImageIcon(const AssetImage('assets/edit_icon.png'), color: HaLanColor.primaryColor,size: AVSize.getSize(context, 16), ),
          ),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: HaLanColor.lightOrange,
          ),
        ),
      ],
    );
  }

  Widget phoneNumber(String number) {
    return Container(
      margin: EdgeInsets.fromLTRB(AVSize.getSize(context, 3.5), AVSize.getSize(context, 18), 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Icon(
            Icons.phone,
            color: HaLanColor.iconColor,
          ),
          Container(
            width: AVSize.getSize(context, 12),
          ),
          Text(
            number,
            style: textTheme.subtitle2
          ),
        ],
      ),
    );
  }

  Future<void> reloadUserInfo() async{
    await Navigator.pushNamed(context, RoutesName.editProfile);
  }
  
}
