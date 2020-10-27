import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halan/base/constant.dart';
import 'package:halan/base/tools.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/repository/user_repository.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'driver_loctaion_event.dart';
part 'driver_loctaion_state.dart';

class DriverLocationBloc extends Bloc<DriverLocationEvent, DriverLocationState> {
  DriverLocationBloc() : super(DriverLocationInitial());
  Timer timer;
  UserRepository repository = UserRepository();
  @override
  Stream<DriverLocationState> mapEventToState(
    DriverLocationEvent event,
  ) async* {
   if(event is DriverLocationEventGetLocation){
     final String tripId = event.trip.tripId;
     try {
     final String token = await repository.getTokenFirebase();

       timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) async {
         final Response response = await get(
             'https://dobody-anvui.firebaseio.com/trips/$tripId.json?auth=$token');
//        if (response != null) print('response: ' + response.body);
         final Map<String, dynamic> data = jsonDecode(response.body) as Map<
             String,
             dynamic>;
         if (data != null) {
           print('++++++++++++++++++++++++++++++++++++');
           print(data[Constant.tripInfo]);
           final Map<String, dynamic> jsonLocation = data[Constant
               .location] as Map<String, dynamic>;
           Vehicle vehicle;
           LatLng busLocation;
           User driver;
           if (jsonLocation != null) {
             print('asdddddddddddddd');
             busLocation = LatLng(
               jsonLocation[Constant.latitude] as double,
               jsonLocation[Constant.longitude] as double,
             );
             print(busLocation.latitude);
           }

           if (data[Constant.tripInfo] != null &&
               data[Constant.tripInfo][Constant.drivers] != null &&
               data[Constant.tripInfo][Constant.drivers][0] != null) {
             final Map<String, dynamic> tripJson = data[Constant
                 .tripInfo] as Map<String, dynamic>;

             final List<dynamic> drivers = tripJson[Constant.drivers] as List<
                 dynamic>;
             driver = User.fromMap(drivers.first as Map<String, dynamic>);
           }
           if (data[Constant.tripInfo] != null &&
               data[Constant.tripInfo][Constant.vehicle] != null) {
             vehicle = Vehicle.fromMap(
                 data[Constant.tripInfo][Constant.vehicle] as Map<
                     String,
                     dynamic>);
           }

           add(DriverLocationEventUpdateLocation(
             vehicle: vehicle,
             busLocation: busLocation,
             driver: driver,
           ));
         }
       }
       );
     }
     on Exception catch(e){
       yield DriverLocationStateFail();
     }
   }

   else if (event is DriverLocationEventUpdateLocation){
     final Uint8List markerIcon = await getBytesFromAsset('assets/carAnimation.png', 100);

     yield DriverLocationStateShowLocation(driver: event.driver,busLocation: event.busLocation,vehicle: event.vehicle,markerIcon: markerIcon);
   }
  }
}
