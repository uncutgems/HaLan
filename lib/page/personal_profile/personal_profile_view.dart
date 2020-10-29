import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/routes.dart';
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
    // TODO: implement initState
    super.initState();
    PersonalProfileInitial();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonalProfileBloc,PersonalProfileState>(
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
      backgroundColor: const Color(0xffE5E5E5),
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Thông tin cá nhân',
        ),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.fromLTRB(24, 24, 16, 0),
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
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        height: 48,
        child: RaisedButton(
          onPressed: (){
            prefs.clear();
            Navigator.popUntil(context, ModalRoute.withName(RoutesName.splashPage));
            Navigator.pushNamed(context, RoutesName.busBookingPage);
          },
          color: HaLanColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text('Đăng xuất', style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: HaLanColor.red100,
          ),
          ),
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
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                width: 16,
              ),
              Text(
                fullName,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 32,
          width: 32,
          child: IconButton(
            onPressed: () async {
              final bool refresh = await Navigator.pushNamed(context, RoutesName.editProfile) as bool;
              if(refresh==true) {
                print('assssssssssssssss');
                personalProfileBloc.add(CallAPIPersonalProfileEvent());
              }
            },
            icon: const ImageIcon(AssetImage('assets/edit_icon.png'), color: HaLanColor.primaryColor,),
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
      margin: const EdgeInsets.fromLTRB(3.5, 18, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const Icon(
            Icons.phone,
            color: HaLanColor.iconColor,
          ),
          Container(
            width: 12,
          ),
          Text(
            number,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> reloadUserInfo() async{
    await Navigator.pushNamed(context, RoutesName.editProfile);
  }

// Widget balance(int balance){
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: <Widget>[
//       const Icon(Icons.attach_money),
//       Text('Số dư: $balance VND'),
//     ],
//   );
// }
}
