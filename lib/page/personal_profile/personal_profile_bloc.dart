import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:halan/repository/user_repository.dart';
import 'package:meta/meta.dart';

part 'personal_profile_event.dart';
part 'personal_profile_state.dart';

class PersonalProfileBloc extends Bloc<PersonalProfileEvent, PersonalProfileState> {
  PersonalProfileBloc() : super(PersonalProfileInitial());
  
  UserRepository userRepository = UserRepository();

  @override
  Stream<PersonalProfileState> mapEventToState(
    PersonalProfileEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if(event is CallAPIPersonalProfileEvent){
      yield PersonalProfileInitial();
    }
  }
}
