import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halan/base/color.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/page/personal_profile/personal_profile_bloc.dart';

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
    return BlocBuilder(
      cubit: personalProfileBloc,
      builder: (BuildContext context,PersonalProfileState state) {
        if (state is PersonalProfileInitial){
          return body(context, state.user);
        }
        return Container();
      },
    );
  }

  Widget body(BuildContext context, User user){
    return SafeArea(
      child: Scaffold(
        backgroundColor: HaLanColor.backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          title: const Text('Thông tin cá nhân',),
        ),
        body: Container(
          alignment: Alignment.topCenter,
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              pictureAndName(user.avatar, user.fullName),
              phoneNumber(user.phoneNumber),
            ],
          ),
        ),
      ),
    );
  }

  Widget pictureAndName(String image, String fullName){
    return ListTile(
      leading: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Image.network(image),
      ),
      title: Text(fullName),
      trailing: IconButton(
        onPressed: (){},
        icon: Container(
          child: const Icon(Icons.edit,
            color: HaLanColor.primaryColor,
          ),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: HaLanColor.bannerColor,
          ),
        ),
      ),
    );
  }

  Widget phoneNumber(String number){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        const Icon(Icons.phone,
        color: HaLanColor.iconColor,),
        Text(number),
      ],
    );
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
