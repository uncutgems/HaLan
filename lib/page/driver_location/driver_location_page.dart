import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:halan/base/color.dart';
import 'package:halan/base/size.dart';
import 'package:halan/base/tools.dart';
import 'package:halan/model/entity.dart';
import 'package:halan/page/driver_location/driver_loctaion_bloc.dart';
import 'package:location/location.dart';

class DriverLocationPage extends StatefulWidget {
  const DriverLocationPage({Key key, this.trip}) : super(key: key);
  final Trip trip;

  @override
  _DriverLocationPageState createState() => _DriverLocationPageState();
}

class _DriverLocationPageState extends State<DriverLocationPage> {
  GoogleMapController _controller;
  List<Marker> allMarkers = <Marker>[];
  Location location = Location();
  DriverLocationBloc bloc = DriverLocationBloc();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;
  LatLng currentLocation;

  @override
  void initState() {
    fetchCurrentLocation();

    super.initState();
    bloc.add(DriverLocationEventGetLocation(widget.trip));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverLocationBloc, DriverLocationState>(
      cubit: bloc,
      builder: (BuildContext context, DriverLocationState state) {
        if (state is DriverLocationInitial) {
          print('Có sao ko');
          return mainScreen(context, null, null,null,null,null);
        } else if (state is DriverLocationStateShowLocation) {
//          print('This is it ${state.busLocation}');
          if (state.busLocation != null) {
//            float bearing = prevLoc.bearingTo(newLoc) ;
            currentLocation ??= state.busLocation;
            _controller.moveCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: state.busLocation,
                  zoom: 20.0,
                  bearing: 45.0,
                  tilt: 45.0),
            ));
            print('yannnnnnnnnnnnnnnnnnnn');
            if (allMarkers.isNotEmpty) {
              allMarkers.removeLast();
            }
            allMarkers.add(Marker(
              markerId: MarkerId(state.vehicle.id),
              draggable: true,
              onTap: () {
                print('Marker Tapped');
              },
              icon: BitmapDescriptor.fromBytes(state.markerIcon),
              position: state.busLocation,
              rotation: getBearingBetweenTwoPoints1(
                currentLocation,
                state.busLocation,
              ),
            ));
            if (currentLocation != null) {
              currentLocation = state.busLocation;
            }
          }
          return mainScreen(context, state.busLocation, state.markerIcon,state.driver.avatar,state.driver,state.vehicle);
        }
        return Container();
      },
    );
  }

  Widget mainScreen(
      BuildContext context, LatLng busLocation, Uint8List markerIcon,String imgUrl,User driver,Vehicle vehicle) {
    LatLng location;
    if (busLocation == null) {
      location = const LatLng(21.027763, 105.834160);
    } else {
      location = busLocation;
    }
    print('This is it $location');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vị trí xe'),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 2 / 3,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: location,
                zoom: 12.0,
              ),
              markers: Set<Marker>.from(allMarkers),
              onMapCreated: mapCreated,
              zoomControlsEnabled: false,
              zoomGesturesEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
            ),
          ),
          if (busLocation != null)
            Align(
              alignment: const Alignment(5 / 10, 0.95),
              child: InkWell(
                onTap: () {
                  _controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: busLocation,
                        zoom: 20.0,
                        bearing: 45.0,
                        tilt: 45.0),
                  ));
                },
                child: Container(
                  height: AppSize.getWidth(context, 40),
                  width: AppSize.getWidth(context, 40),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: HaLanColor.white),
                  child: const Icon(Icons.compare_arrows,
                      color: HaLanColor.gray80),
                ),
              ),
            ),
          Align(
            alignment: const Alignment(9 / 10, 0.95),
            child: InkWell(
              onTap: movetoMyLocation,
              child: Container(
                height: AppSize.getWidth(context, 40),
                width: AppSize.getWidth(context, 40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: HaLanColor.white),
                child: const Icon(Icons.location_searching,
                    color: HaLanColor.gray80),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: bottomInformation(context,imgUrl,driver,vehicle),
    );
  }

  Widget bottomInformation(BuildContext context, String imgUrl,User driver,Vehicle vehicle){
    return  Container(
      decoration:const BoxDecoration(color: HaLanColor.primaryColor,borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16),),),
      child: Padding(
        padding:  EdgeInsets.all(AppSize.getWidth(context, 16),),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Thông tin chuyến đi',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: HaLanColor.white,
                  fontWeight: FontWeight.bold,
                  fontSize: AppSize.getFontSize(context, 14)),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding:  EdgeInsets.only(top:AppSize.getWidth(context, 16)),
                  child: CircleAvatar(
                    radius: AppSize.getWidth(context, 20),
                    backgroundImage: imgUrl!=null? NetworkImage(imgUrl):null,
                    backgroundColor: Colors.blue,
                  ),
                ),
                Container(width: AppSize.getWidth(context, 8),),
                Expanded(child:driver!=null? Text('${driver.fullName}  ( ${driver.phoneNumber} )',style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: HaLanColor.white,
                    fontWeight: FontWeight.bold,
                    fontSize: AppSize.getFontSize(context, 16)),): Text(''),),
                CircleAvatar(child: IconButton(icon:const Icon(Icons.call), onPressed: (){},color: HaLanColor.white,),backgroundColor: HaLanColor.green,radius: AppSize.getWidth(context, 20) ,),
              ],
            ),
            Center(child:Text(vehicle!=null?vehicle.numberPlate:'',style:Theme.of(context).textTheme.bodyText2.copyWith(
                color: HaLanColor.white,
                fontWeight: FontWeight.bold,
                fontSize: AppSize.getFontSize(context, 18)) ,))
          ],
        ),
      ),
    );
  }

  void mapCreated(GoogleMapController controller) {
//    setState(() {
    _controller = controller;
//    });
  }

  void movetoMyLocation() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: LatLng(_locationData.latitude, _locationData.longitude),
          zoom: 20.0,
          bearing: 45.0,
          tilt: 45.0),
    ));
  }

  void movetoCarLocation(LatLng busLocation) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
          target: busLocation, zoom: 20.0, bearing: 45.0, tilt: 45.0),
    ));
  }

  Future<void> fetchCurrentLocation() async {
    try {
      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }
      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
      _locationData = await location.getLocation();
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        //error = e.message;
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        //error = e.message;
      }
      location = null;
    }
  }
}
