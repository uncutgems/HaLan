import 'dart:convert';

import 'package:halan/base/constant.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

/// Các hàm lấy dữ liệu - Tools
/// Lấy dữ liệu dạng string từ map mặc định ''
String getString(String key, Map<String, dynamic> data) {
  String result = '';
  if (data == null) {
    result = '';
  } else if (data[key] == null) {
    result = '';
  } else if (!data.containsKey(key)) {
    result = '';
  } else {
    result = data[key].toString();
  }
  return result;
}

///Lấy dữ liệu int từ map mặc định 0
int getInt(String key, Map<String, dynamic> data) {
  int result = 0;
  if (data == null) {
    result = 0;
  } else if (data[key] == null) {
    result = 0;
  } else if (!data.containsKey(key)) {
    result = 0;
  } else {
    result = int.parse(data[key].toString());
  }
  return result;
}

/// Lấy dữ liệu double từ map mặc định 0
double getDouble(String key, Map<String, dynamic> data) {
  double result = 0;
  if (data == null) {
    result = 0;
  } else if (data[key] == null) {
    result = 0;
  } else if (!data.containsKey(key)) {
    result = 0;
  } else {
    result = double.parse(data[key].toString());
  }
  return result;
}

/// lấy dữ liệu bool từ map mặc định false
bool getBool(String key, Map<String, dynamic> data) {
  bool result = false;
  if (data == null) {
    result = false;
  } else if (data[key] == null) {
    result = false;
  } else if (!data.containsKey(key)) {
    result = false;
  } else {
    result = data[key] as bool;
  }
  return result;
}

/// Lấy list double entity
List<double> getListDouble(String key, Map<String, dynamic> data) {
  final List<double> result = <double>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  }

  data[key].forEach((dynamic item) {
    result.add(item as double);
  });
  return result;
}

/// Get list int entity
List<int> getListInt(String key, Map<String, dynamic> data) {
  final List<int> result = <int>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  }

  data[key].forEach((dynamic item) {
    result.add(item as int);
  });
  return result;
}

/// Get list String entity
List<String> getListString(String key, Map<String, dynamic> data) {
  final List<String> result = <String>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  }

  data[key].forEach((dynamic item) {
    result.add(item as String);
  });
  return result;
}

/// Get list Goods object entity
List<Goods> getListGoodsObject(String key, Map<String, dynamic> data) {
  final List<Goods> result = <Goods>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  }

  data[key].forEach((dynamic item) {
    result.add(Goods.fromJson(item as Map<String, dynamic>));
  });
  return result;
}

/// parse Point
List<Point> parseListPoint(String key, Map<String, dynamic> data) {
  final List<Point> result = <Point>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  }

  data[key].forEach((dynamic item) {
    result.add(Point.fromMap(item as Map<String, dynamic>));
  });
  return result;
}

/// parse Point
List<Seat> parseListSeat(String key, Map<String, dynamic> data) {
  final List<Seat> result = <Seat>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  }

  data[key].forEach((dynamic item) {
    result.add(Seat.fromMap(item as Map<String, dynamic>));
  });
  return result;
}

// parse list user
List<User> parseListUser(String key, Map<String, dynamic> data) {
  final List<User> result = <User>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  }

  data[key].forEach((dynamic item) {
    result.add(User.fromMap(item as Map<String, dynamic>));
  });
  return result;
}

// parse list telecom
List<TelecomCompany> parseListTelecom(String key, Map<String, dynamic> data) {
  final List<TelecomCompany> result = <TelecomCompany>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  }

  data[key].forEach((dynamic item) {
    result.add(TelecomCompany.fromJson(item as Map<String, dynamic>));
  });
  return result;
}

List<Surcharge> getListSurcharge(String key, Map<String, dynamic> data) {
  final List<Surcharge> result = <Surcharge>[];
  if (data == null) {
    return result;
  }
  if (data[key] == null) {
    return result;
  }
  if (!data.containsKey(key)) {
    return result;
  }

  data[key].forEach((dynamic item) {
    result.add(Surcharge.fromMap(item as Map<String, dynamic>));
  });
  return result;
}

@JsonSerializable(nullable: false)
class AVResponse {
  AVResponse({
    @required this.isOK,
    @required this.code,
    @required this.response,
    this.message,
  }); // case not ok show message

  final bool isOK; // check Response is OK
  final int code; // status code
  final Map<String, dynamic> response; // data body response
  final String message;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.ok: isOK,
      Constant.code: code,
      Constant.response: response,
      Constant.message: message,
    };
  }
}

@JsonSerializable(nullable: false)
class NotificationEntity {
  NotificationEntity({
    this.notificationId,
    this.userId,
    this.notificationCode,
    this.notificationContent,
    this.createdDate,
    this.isRead,
    this.objectId,
  });

  factory NotificationEntity.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return NotificationEntity();
    }
    return NotificationEntity(
      notificationId: getString(Constant.notificationId, data),
      userId: getString(Constant.userId, data),
      notificationCode: getInt(Constant.notificationCode, data),
      notificationContent: getString(Constant.notificationContent, data),
      createdDate: getInt(Constant.createdDate, data),
      isRead: getBool(Constant.isRead, data),
      objectId: getString(Constant.objectId, data),
    );
  }

  final String notificationId;
  final String userId;
  final int notificationCode;
  final String notificationContent;
  final int createdDate;
  final bool isRead;
  final String objectId;

  NotificationEntity copyWith({
    String notificationId,
    String userId,
    int notificationCode,
    String notificationContent,
    int createdDate,
    bool isRead,
    String objectId,
  }) {
    if ((notificationId == null ||
            identical(notificationId, this.notificationId)) &&
        (userId == null || identical(userId, this.userId)) &&
        (notificationCode == null ||
            identical(notificationCode, this.notificationCode)) &&
        (notificationContent == null ||
            identical(notificationContent, this.notificationContent)) &&
        (createdDate == null || identical(createdDate, this.createdDate)) &&
        (isRead == null || identical(isRead, this.isRead)) &&
        (objectId == null || identical(objectId, this.objectId))) {
      return this;
    }

    return NotificationEntity(
      notificationId: notificationId ?? this.notificationId,
      userId: userId ?? this.userId,
      notificationCode: notificationCode ?? this.notificationCode,
      notificationContent: notificationContent ?? this.notificationContent,
      createdDate: createdDate ?? this.createdDate,
      isRead: isRead ?? this.isRead,
      objectId: objectId ?? this.objectId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.notificationId: notificationId,
      Constant.userId: userId,
      Constant.notificationCode: notificationCode,
      Constant.notificationContent: notificationContent,
      Constant.createdDate: createdDate,
      Constant.isRead: isRead,
      Constant.objectId: objectId,
    };
  }
}

@JsonSerializable(nullable: false)
class Point {
  Point(
      {this.address,
      this.district,
      this.id,
      this.latitude,
      this.longitude,
      this.name,
      this.orderTransshipment,
      this.pointType,
      this.province,
      this.transshipmentId,
      this.transshipmentPrice,
      this.regionInfo,
      this.listTransshipmentPoint,
      this.listPrice,
      this.completedTransshipment});

  factory Point.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    return Point(
      address: getString(Constant.address, data),
      district: getString(Constant.district, data),
      id: getString(Constant.id, data),
      latitude: getDouble(Constant.latitude, data),
      longitude: getDouble(Constant.longitude, data),
      name: getString(Constant.name, data),
      orderTransshipment: getInt(Constant.orderTransshipment, data),
      pointType: getInt(Constant.pointType, data),
      province: getString(Constant.province, data),
      transshipmentId: getString(Constant.transshipmentId, data),
      transshipmentPrice: getDouble(Constant.transshipmentPrice, data),
      regionInfo:
          RegionInfo.fromMap(data[Constant.regionInfo] as Map<String, dynamic>),
      listTransshipmentPoint:
          parseListPoint(Constant.listTransshipmentPoint, data),
      listPrice: getListDouble(Constant.listPrice, data),
      completedTransshipment: getBool(Constant.completedTransshipment, data),
    );
  }

  final String address;
  final String district;
  final String id;
  final double latitude;
  final double longitude;
  final String name;
  final int orderTransshipment;
  final int pointType;
  final String province;
  final String transshipmentId;
  final double transshipmentPrice;
  final RegionInfo regionInfo;
  final List<Point> listTransshipmentPoint;
  final List<double> listPrice;
  final bool completedTransshipment;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.address: address,
      Constant.district: district,
      Constant.id: id,
      Constant.latitude: latitude,
      Constant.longitude: longitude,
      Constant.name: name,
      Constant.orderTransshipment: orderTransshipment,
      Constant.pointType: pointType,
      Constant.province: province,
      Constant.transshipmentId: transshipmentId,
      Constant.transshipmentPrice: transshipmentPrice,
      Constant.regionInfo: regionInfo != null ? regionInfo.toJson() : null,
      Constant.listTransshipmentPoint: listTransshipmentPoint,
      Constant.listPrice: listPrice,
      Constant.completedTransshipment: completedTransshipment
    };
  }

  Point copyWith({
    String address,
    String district,
    String id,
    double latitude,
    double longitude,
    String name,
    int orderTransshipment,
    int pointType,
    String province,
    String transshipmentId,
    double transshipmentPrice,
    RegionInfo regionInfo,
    List<Point> listTransshipmentPoint,
    List<double> listPrice,
    bool completedTransshipment,
  }) {
    if ((address == null || identical(address, this.address)) &&
        (district == null || identical(district, this.district)) &&
        (id == null || identical(id, this.id)) &&
        (latitude == null || identical(latitude, this.latitude)) &&
        (longitude == null || identical(longitude, this.longitude)) &&
        (name == null || identical(name, this.name)) &&
        (orderTransshipment == null ||
            identical(orderTransshipment, this.orderTransshipment)) &&
        (pointType == null || identical(pointType, this.pointType)) &&
        (province == null || identical(province, this.province)) &&
        (transshipmentId == null ||
            identical(transshipmentId, this.transshipmentId)) &&
        (transshipmentPrice == null ||
            identical(transshipmentPrice, this.transshipmentPrice)) &&
        (regionInfo == null || identical(regionInfo, this.regionInfo)) &&
        (listTransshipmentPoint == null ||
            identical(listTransshipmentPoint, this.listTransshipmentPoint)) &&
        (listPrice == null || identical(listPrice, this.listPrice)) &&
        (completedTransshipment == null ||
            identical(completedTransshipment, this.completedTransshipment))) {
      return this;
    }

    return Point(
      address: address ?? this.address,
      district: district ?? this.district,
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      name: name ?? this.name,
      orderTransshipment: orderTransshipment ?? this.orderTransshipment,
      pointType: pointType ?? this.pointType,
      province: province ?? this.province,
      transshipmentId: transshipmentId ?? this.transshipmentId,
      transshipmentPrice: transshipmentPrice ?? this.transshipmentPrice,
      regionInfo: regionInfo ?? this.regionInfo,
      listTransshipmentPoint:
          listTransshipmentPoint ?? this.listTransshipmentPoint,
      listPrice: listPrice ?? this.listPrice,
      completedTransshipment:
          completedTransshipment ?? this.completedTransshipment,
    );
  }
}

@JsonSerializable(nullable: false)
class RegionInfo {
  RegionInfo({
    this.id,
    this.name,
    this.province,
    this.department,
  });

  factory RegionInfo.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    return RegionInfo(
      id: getString(Constant.id, data),
      name: getString(Constant.name, data),
      province: getString(Constant.province, data),
      department: getInt(Constant.department, data),
    );
  }

  final String id;
  final String name;
  final String province;
  final int department;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.id: id,
      Constant.name: name,
      Constant.province: province,
      Constant.department: department,
    };
  }

  RegionInfo copyWith({
    String id,
    String name,
    String province,
    int department,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (province == null || identical(province, this.province)) &&
        (department == null || identical(department, this.department))) {
      return this;
    }

    return RegionInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      province: province ?? this.province,
      department: department ?? this.department,
    );
  }
}

@JsonSerializable(nullable: false)
class Vehicle {
  Vehicle({
    this.id,
    this.numberPlate,
    this.seatMapId,
    this.vehicleTypeId,
    this.estimatedFuelConsumption,
  });

  factory Vehicle.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    return Vehicle(
      id: getString(Constant.id, data),
      numberPlate: getString(Constant.numberPlate, data),
      seatMapId: getString(Constant.seatMapId, data),
      vehicleTypeId: getString(Constant.vehicleTypeId, data),
      estimatedFuelConsumption:
          getDouble(Constant.estimatedFuelConsumption, data),
    );
  }

  final String id;
  final String numberPlate;
  final String seatMapId;
  final String vehicleTypeId;
  final double estimatedFuelConsumption;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.id: id,
      Constant.numberPlate: numberPlate,
      Constant.seatMapId: seatMapId,
      Constant.vehicleTypeId: vehicleTypeId,
      Constant.estimatedFuelConsumption: estimatedFuelConsumption,
    };
  }

  Vehicle copyWith({
    String id,
    String numberPlate,
    String seatMapId,
    String vehicleTypeId,
    double estimatedFuelConsumption,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (numberPlate == null || identical(numberPlate, this.numberPlate)) &&
        (seatMapId == null || identical(seatMapId, this.seatMapId)) &&
        (vehicleTypeId == null ||
            identical(vehicleTypeId, this.vehicleTypeId)) &&
        (estimatedFuelConsumption == null ||
            identical(
                estimatedFuelConsumption, this.estimatedFuelConsumption))) {
      return this;
    }

    return Vehicle(
      id: id ?? this.id,
      numberPlate: numberPlate ?? this.numberPlate,
      seatMapId: seatMapId ?? this.seatMapId,
      vehicleTypeId: vehicleTypeId ?? this.vehicleTypeId,
      estimatedFuelConsumption:
          estimatedFuelConsumption ?? this.estimatedFuelConsumption,
    );
  }
}

@JsonSerializable(nullable: false)
class ContractRepresentation {
  ContractRepresentation({
    this.tripId,
    this.fullName,
    this.companyName,
    this.phoneNumber,
    this.address,
    this.email,
    this.contractNumber,
    this.searchString,
  });

  factory ContractRepresentation.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    return ContractRepresentation(
      tripId: getString(Constant.tripId, data),
      fullName: getString(Constant.fullName, data),
      companyName: getString(Constant.companyName, data),
      phoneNumber: getString(Constant.phoneNumber, data),
      address: getString(Constant.address, data),
      email: getString(Constant.email, data),
      contractNumber: getString(Constant.contractNumber, data),
      searchString: getString(Constant.searchString, data),
    );
  }

  final String tripId;
  final String fullName;
  final String companyName;
  final String phoneNumber;
  final String address;
  final String email;
  final String contractNumber;
  final String searchString;

  ContractRepresentation copyWith({
    String tripId,
    String fullName,
    String companyName,
    String phoneNumber,
    String address,
    String email,
    String contractNumber,
    String searchString,
  }) {
    if ((tripId == null || identical(tripId, this.tripId)) &&
        (fullName == null || identical(fullName, this.fullName)) &&
        (companyName == null || identical(companyName, this.companyName)) &&
        (phoneNumber == null || identical(phoneNumber, this.phoneNumber)) &&
        (address == null || identical(address, this.address)) &&
        (email == null || identical(email, this.email)) &&
        (contractNumber == null ||
            identical(contractNumber, this.contractNumber)) &&
        (searchString == null || identical(searchString, this.searchString))) {
      return this;
    }

    return ContractRepresentation(
      tripId: tripId ?? this.tripId,
      fullName: fullName ?? this.fullName,
      companyName: companyName ?? this.companyName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      email: email ?? this.email,
      contractNumber: contractNumber ?? this.contractNumber,
      searchString: searchString ?? this.searchString,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.tripId: tripId,
      Constant.fullName: fullName,
      Constant.companyName: companyName,
      Constant.phoneNumber: phoneNumber,
      Constant.address: address,
      Constant.email: email,
      Constant.contractNumber: contractNumber,
      Constant.searchString: searchString,
    };
  }
}

@JsonSerializable(nullable: false)
class AdditionPrice {
  AdditionPrice({
    this.id,
    this.companyId,
    this.listRouteId,
    this.listScheduleId,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.name,
    this.type,
    this.amount,
    this.mode,
    this.platform,
    this.listUserType,
  });

  factory AdditionPrice.fromJson(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    return AdditionPrice(
      id: getString(Constant.id, data),
      companyId: getString(Constant.companyId, data),
      listRouteId: getListString(Constant.listRouteId, data),
      listScheduleId: getListString(Constant.listScheduleId, data),
      platform: getListInt(Constant.platform, data),
      listUserType: getListInt(Constant.listUserType, data),
      startDate: getInt(Constant.startDate, data),
      endDate: getInt(Constant.endDate, data),
      startTime: getInt(Constant.startTime, data),
      endTime: getInt(Constant.endTime, data),
      name: getString(Constant.name, data),
      type: getInt(Constant.type, data),
      amount: getDouble(Constant.amount, data),
      mode: getInt(Constant.mode, data),
    );
  }

  final String id;
  final String companyId;
  final List<String> listRouteId;
  final List<String> listScheduleId;
  final int startDate;
  final int endDate;
  final int startTime;
  final int endTime;
  final String name;
  final int type;
  final double amount;
  final int mode;
  final List<int> platform;
  final List<int> listUserType;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.id: id,
      Constant.companyId: companyId,
      Constant.listScheduleId: listScheduleId,
      Constant.listRouteId: listRouteId,
      Constant.startDate: startDate,
      Constant.endDate: endDate,
      Constant.startTime: startTime,
      Constant.endTime: endTime,
      Constant.name: name,
      Constant.type: type,
      Constant.amount: amount,
      Constant.mode: mode,
    };
  }

  AdditionPrice copyWith({
    String id,
    String companyId,
    List<String> listRouteId,
    List<String> listScheduleId,
    int startDate,
    int endDate,
    int startTime,
    int endTime,
    String name,
    int type,
    double amount,
    int mode,
    List<int> platform,
    List<int> listUserType,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (companyId == null || identical(companyId, this.companyId)) &&
        (listRouteId == null || identical(listRouteId, this.listRouteId)) &&
        (listScheduleId == null ||
            identical(listScheduleId, this.listScheduleId)) &&
        (startDate == null || identical(startDate, this.startDate)) &&
        (endDate == null || identical(endDate, this.endDate)) &&
        (startTime == null || identical(startTime, this.startTime)) &&
        (endTime == null || identical(endTime, this.endTime)) &&
        (name == null || identical(name, this.name)) &&
        (type == null || identical(type, this.type)) &&
        (amount == null || identical(amount, this.amount)) &&
        (mode == null || identical(mode, this.mode)) &&
        (platform == null || identical(platform, this.platform)) &&
        (listUserType == null || identical(listUserType, this.listUserType))) {
      return this;
    }

    return AdditionPrice(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      listRouteId: listRouteId ?? this.listRouteId,
      listScheduleId: listScheduleId ?? this.listScheduleId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      name: name ?? this.name,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      mode: mode ?? this.mode,
      platform: platform ?? this.platform,
      listUserType: listUserType ?? this.listUserType,
    );
  }
}

@JsonSerializable(nullable: false)
class SeatMap {
  SeatMap({
    this.companyId,
    this.isSample,
    this.numberOfColumns,
    this.numberOfFloors,
    this.numberOfRows,
    this.seatList,
    this.seatMapId,
    this.seatMapName,
    this.status,
    this.type,
    this.vehicleTypeId,
  });

  factory SeatMap.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return SeatMap();
    }
    return SeatMap(
      companyId: getString(Constant.companyId, data),
      isSample: getBool(Constant.isSample, data),
      numberOfColumns: getInt(Constant.numberOfColumns, data),
      numberOfFloors: getInt(Constant.numberOfFloors, data),
      numberOfRows: getInt(Constant.numberOfRows, data),
      seatList: parseListSeat(Constant.seatList, data),
      seatMapId: getString(Constant.seatMapId, data),
      seatMapName: getString(Constant.seatMapName, data),
      status: getInt(Constant.status, data),
      type: getInt(Constant.type, data),
      vehicleTypeId: getString(Constant.vehicleTypeId, data),
    );
  }

  final String companyId;
  final bool isSample;
  final int numberOfColumns;
  final int numberOfFloors;
  final int numberOfRows;
  final List<Seat> seatList;
  final String seatMapId;
  final String seatMapName;
  final int status;
  final int type;
  final String vehicleTypeId;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.companyId: companyId,
      Constant.isSample: isSample,
      Constant.numberOfColumns: numberOfColumns,
      Constant.numberOfFloors: numberOfFloors,
      Constant.numberOfRows: numberOfRows,
      Constant.seatList: seatList,
      Constant.seatMapId: seatMapId,
      Constant.seatMapName: seatMapName,
      Constant.status: status,
      Constant.type: type,
      Constant.vehicleTypeId: vehicleTypeId,
    };
  }

  SeatMap copyWith({
    String companyId,
    bool isSample,
    int numberOfColumns,
    int numberOfFloors,
    int numberOfRows,
    List<Seat> seatList,
    String seatMapId,
    String seatMapName,
    int status,
    int type,
    String vehicleTypeId,
  }) {
    if ((companyId == null || identical(companyId, this.companyId)) &&
        (isSample == null || identical(isSample, this.isSample)) &&
        (numberOfColumns == null ||
            identical(numberOfColumns, this.numberOfColumns)) &&
        (numberOfFloors == null ||
            identical(numberOfFloors, this.numberOfFloors)) &&
        (numberOfRows == null || identical(numberOfRows, this.numberOfRows)) &&
        (seatList == null || identical(seatList, this.seatList)) &&
        (seatMapId == null || identical(seatMapId, this.seatMapId)) &&
        (seatMapName == null || identical(seatMapName, this.seatMapName)) &&
        (status == null || identical(status, this.status)) &&
        (type == null || identical(type, this.type)) &&
        (vehicleTypeId == null ||
            identical(vehicleTypeId, this.vehicleTypeId))) {
      return this;
    }

    return SeatMap(
      companyId: companyId ?? this.companyId,
      isSample: isSample ?? this.isSample,
      numberOfColumns: numberOfColumns ?? this.numberOfColumns,
      numberOfFloors: numberOfFloors ?? this.numberOfFloors,
      numberOfRows: numberOfRows ?? this.numberOfRows,
      seatList: seatList ?? this.seatList,
      seatMapId: seatMapId ?? this.seatMapId,
      seatMapName: seatMapName ?? this.seatMapName,
      status: status ?? this.status,
      type: type ?? this.type,
      vehicleTypeId: vehicleTypeId ?? this.vehicleTypeId,
    );
  }
}

@JsonSerializable(nullable: false)
class Seat {
  Seat({
    this.column,
    this.extraPrice,
    this.floor,
    this.images,
    this.listTicketCode,
    this.listTicketId,
    this.listUserId,
    this.overTime,
    this.row,
    this.seatId,
    this.seatStatus,
    this.seatType,
    this.isPicked,
    this.ticketStatus,
    this.paid,
    this.indexMax,
  });

  factory Seat.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return Seat();
    }

    return Seat(
      column: getInt(Constant.column, data),
      extraPrice: getDouble(Constant.extraPrice, data),
      floor: getInt(Constant.floor, data),
      images: getListString(Constant.images, data),
      listTicketCode: getListString(Constant.listTicketCode, data),
      listTicketId: getListString(Constant.listTicketId, data),
      listUserId: getListString(Constant.listUserId, data),
      overTime: getInt(Constant.overTime, data),
      row: getInt(Constant.row, data),
      seatId: getString(Constant.seatId, data),
      seatStatus: getInt(Constant.seatStatus, data),
      seatType: getInt(Constant.seatType, data),
      isPicked: getBool(Constant.isPicked, data),
      ticketStatus: getInt(Constant.ticketStatus, data),
      paid: getBool(Constant.paid, data),
      indexMax: getInt(Constant.indexMax, data),
    );
  }

  final int column;
  final double extraPrice;
  final int floor;
  final List<String> images;
  final List<String> listTicketCode;
  final List<String> listTicketId;
  final List<String> listUserId;
  final int overTime;
  final int row;
  final String seatId;
  final int seatStatus;
  final int seatType;
  final bool isPicked;
  final int ticketStatus;
  final bool paid;
  final int indexMax;

  Seat copyWith({
    int column,
    double extraPrice,
    int floor,
    List<String> images,
    List<String> listTicketCode,
    List<String> listTicketId,
    List<String> listUserId,
    int overTime,
    int row,
    String seatId,
    int seatStatus,
    int seatType,
    bool isPicked,
    int ticketStatus,
    bool paid,
    int indexMax,
  }) {
    if ((column == null || identical(column, this.column)) &&
        (extraPrice == null || identical(extraPrice, this.extraPrice)) &&
        (floor == null || identical(floor, this.floor)) &&
        (images == null || identical(images, this.images)) &&
        (listTicketCode == null ||
            identical(listTicketCode, this.listTicketCode)) &&
        (listTicketId == null || identical(listTicketId, this.listTicketId)) &&
        (listUserId == null || identical(listUserId, this.listUserId)) &&
        (overTime == null || identical(overTime, this.overTime)) &&
        (row == null || identical(row, this.row)) &&
        (seatId == null || identical(seatId, this.seatId)) &&
        (seatStatus == null || identical(seatStatus, this.seatStatus)) &&
        (seatType == null || identical(seatType, this.seatType)) &&
        (isPicked == null || identical(isPicked, this.isPicked)) &&
        (ticketStatus == null || identical(ticketStatus, this.ticketStatus)) &&
        (paid == null || identical(paid, this.paid)) &&
        (indexMax == null || identical(indexMax, this.indexMax))) {
      return this;
    }

    return Seat(
      column: column ?? this.column,
      extraPrice: extraPrice ?? this.extraPrice,
      floor: floor ?? this.floor,
      images: images ?? this.images,
      listTicketCode: listTicketCode ?? this.listTicketCode,
      listTicketId: listTicketId ?? this.listTicketId,
      listUserId: listUserId ?? this.listUserId,
      overTime: overTime ?? this.overTime,
      row: row ?? this.row,
      seatId: seatId ?? this.seatId,
      seatStatus: seatStatus ?? this.seatStatus,
      seatType: seatType ?? this.seatType,
      isPicked: isPicked ?? this.isPicked,
      ticketStatus: ticketStatus ?? this.ticketStatus,
      paid: paid ?? this.paid,
      indexMax: indexMax ?? this.indexMax,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.column: column,
      Constant.extraPrice: extraPrice,
      Constant.floor: floor,
      Constant.images: images,
      Constant.listTicketCode: listTicketCode,
      Constant.listTicketId: listTicketId,
      Constant.listUserId: listUserId,
      Constant.overTime: overTime,
      Constant.row: row,
      Constant.seatId: seatId,
      Constant.seatStatus: seatStatus,
      Constant.seatType: seatType,
      Constant.isPicked: isPicked,
      Constant.ticketStatus: ticketStatus,
      Constant.paid: paid,
      Constant.indexMax: indexMax,
    };
  }
}

@JsonSerializable(nullable: false)
class RouteEntity {
  RouteEntity({
    this.displayPrice,
    this.id,
    this.images,
    this.listPointId,
    this.name,
    this.nameShort,
    this.phoneNumber,
    this.childrenTicketRatio,
    this.listTransshipmentPoint,
    this.listPoint,
    this.listPriceByVehicleType,
  });

  factory RouteEntity.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return RouteEntity();
    }
    return RouteEntity(
      displayPrice: getDouble(Constant.displayPrice, data),
      id: data[Constant.name] == null
          ? getString(Constant.routeId, data)
          : getString(Constant.id, data),
      images: getListString(Constant.images, data),
      listPointId: getListString(Constant.listPointId, data),
      name: data[Constant.name] == null
          ? getString(Constant.routeName, data)
          : getString(Constant.name, data),
      nameShort: getString(Constant.nameShort, data),
      phoneNumber: getString(Constant.phoneNumber, data),
      childrenTicketRatio: getDouble(Constant.childrenTicketRatio, data),
      listTransshipmentPoint:
          data[Constant.listTransshipmentPoint] as Map<String, dynamic>,
      listPoint: parseListPoint(Constant.listPoint, data),
      listPriceByVehicleType:
          getListDouble(Constant.listPriceByVehicleType, data),
    );
  }

  final double displayPrice;
  final String id;
  final List<String> images;
  final List<String> listPointId;
  final String name;
  final String nameShort;
  final String phoneNumber;
  final double childrenTicketRatio;
  final Map<String, dynamic> listTransshipmentPoint;
  final List<Point> listPoint;
  final List<double> listPriceByVehicleType;

  RouteEntity copyWith({
    double displayPrice,
    String id,
    List<String> images,
    List<String> listPointId,
    String name,
    String nameShort,
    String phoneNumber,
    double childrenTicketRatio,
    Map<String, dynamic> listTransshipmentPoint,
    List<Point> listPoint,
    List<double> listPriceByVehicleType,
  }) {
    if ((displayPrice == null || identical(displayPrice, this.displayPrice)) &&
        (id == null || identical(id, this.id)) &&
        (images == null || identical(images, this.images)) &&
        (listPointId == null || identical(listPointId, this.listPointId)) &&
        (name == null || identical(name, this.name)) &&
        (nameShort == null || identical(nameShort, this.nameShort)) &&
        (phoneNumber == null || identical(phoneNumber, this.phoneNumber)) &&
        (childrenTicketRatio == null ||
            identical(childrenTicketRatio, this.childrenTicketRatio)) &&
        (listTransshipmentPoint == null ||
            identical(listTransshipmentPoint, this.listTransshipmentPoint)) &&
        (listPoint == null || identical(listPoint, this.listPoint)) &&
        (listPriceByVehicleType == null ||
            identical(listPriceByVehicleType, this.listPriceByVehicleType))) {
      return this;
    }

    return RouteEntity(
      displayPrice: displayPrice ?? this.displayPrice,
      id: id ?? this.id,
      images: images ?? this.images,
      listPointId: listPointId ?? this.listPointId,
      name: name ?? this.name,
      nameShort: nameShort ?? this.nameShort,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      childrenTicketRatio: childrenTicketRatio ?? this.childrenTicketRatio,
      listTransshipmentPoint:
          listTransshipmentPoint ?? this.listTransshipmentPoint,
      listPoint: listPoint ?? this.listPoint,
      listPriceByVehicleType:
          listPriceByVehicleType ?? this.listPriceByVehicleType,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.displayPrice: displayPrice,
      Constant.id: id,
      Constant.images: images,
      Constant.listPointId: listPointId,
      Constant.name: name,
      Constant.nameShort: nameShort,
      Constant.phoneNumber: phoneNumber,
      Constant.childrenTicketRatio: childrenTicketRatio,
      Constant.listTransshipmentPoint: listTransshipmentPoint,
      Constant.listPoint: listPoint,
      Constant.listPriceByVehicleType: listPriceByVehicleType,
    };
  }
}

class Trip {
  Trip({
    this.date,
    this.planId,
    this.route,
    this.runTime,
    this.seatMap,
    this.startTime,
    this.startTimeReality,
    this.startDateReality,
    this.totalEmptySeat,
    this.totalSeat,
    this.tripId,
    this.scheduleId,
    this.tripStatus,
    this.vehicleTypeId,
    this.vehicleTypeName,
    this.additionPriceForUserType,
    this.vehicle,
    this.contractRepresentation,
    this.pointUp,
    this.pointDown,
    this.price,
    this.drivers,
    this.assistants,
    this.listLockTrip,
    this.note,
  });

  factory Trip.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return Trip();
    }

    return Trip(
      date: getInt(Constant.date, data),
      planId: getString(Constant.planId, data),
      route: data[Constant.route] == null
          ? RouteEntity.fromMap(
              data[Constant.routeInfo] as Map<String, dynamic>)
          : RouteEntity.fromMap(data[Constant.route] as Map<String, dynamic>),
      runTime: getInt(Constant.runTime, data),
      seatMap: SeatMap.fromMap(data[Constant.seatMap] as Map<String, dynamic>),
      startTime: getInt(Constant.startTime, data),
      startTimeReality: getInt(Constant.startTimeReality, data),
      startDateReality: getString(Constant.startDateReality, data),
      totalEmptySeat: getInt(Constant.totalEmptySeat, data),
      totalSeat: getInt(Constant.totalSeat, data),
      tripId: getString(Constant.tripId, data),
      scheduleId: getString(Constant.scheduleId, data),
      tripStatus: getInt(Constant.tripStatus, data),
      vehicleTypeId: getString(Constant.vehicleTypeId, data),
      vehicleTypeName: getString(Constant.vehicleTypeName, data),
      additionPriceForUserType: AdditionPrice.fromJson(
          data[Constant.additionPriceForUserType] as Map<String, dynamic>),
      vehicle: Vehicle.fromMap(data[Constant.vehicle] as Map<String, dynamic>),
      contractRepresentation: ContractRepresentation.fromMap(
          data[Constant.contractRepresentation] as Map<String, dynamic>),
      pointUp: Point.fromMap(data[Constant.pointUp] as Map<String, dynamic>),
      pointDown:
          Point.fromMap(data[Constant.pointDown] as Map<String, dynamic>),
      price: getDouble(Constant.price, data),
      listLockTrip: getListInt(Constant.listLockTrip, data),
      drivers: parseListUser(Constant.drivers, data),
      assistants: parseListUser(Constant.assistants, data),
      note: getString(Constant.note, data),
    );
  }

  final int date;
  final String planId;
  final RouteEntity route;
  final int runTime;
  final SeatMap seatMap;
  final int startTime;
  final int startTimeReality;
  final String startDateReality;
  final int totalEmptySeat;
  final int totalSeat;
  final String tripId;
  final String scheduleId;
  final int tripStatus;
  final String vehicleTypeId;
  final String vehicleTypeName;
  final AdditionPrice additionPriceForUserType;
  final Vehicle vehicle;
  final ContractRepresentation contractRepresentation;
  final Point pointDown;
  final Point pointUp;
  final double price;
  final List<User> drivers;
  final List<User> assistants;
  final List<int> listLockTrip;
  final String note;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.date: date,
      Constant.planId: planId,
      Constant.route: route,
      Constant.runTime: runTime,
      Constant.seatMap: seatMap,
      Constant.startTime: startTime,
      Constant.startTimeReality: startTimeReality,
      Constant.startDateReality: startDateReality,
      Constant.totalEmptySeat: totalEmptySeat,
      Constant.totalSeat: totalSeat,
      Constant.tripId: tripId,
      Constant.scheduleId: scheduleId,
      Constant.tripStatus: tripStatus,
      Constant.vehicleTypeId: vehicleTypeId,
      Constant.vehicleTypeName: vehicleTypeName,
      Constant.additionPriceForUserType: additionPriceForUserType,
      Constant.vehicle: vehicle,
      Constant.contractRepresentation: contractRepresentation,
      Constant.pointUp: pointUp,
      Constant.pointDown: pointDown,
      Constant.price: price,
      Constant.drivers: drivers,
      Constant.assistants: assistants,
      Constant.listLockTrip: listLockTrip,
      Constant.note: note,
    };
  }

  Trip copyWith({
    int date,
    String planId,
    RouteEntity route,
    int runTime,
    SeatMap seatMap,
    int startTime,
    int startTimeReality,
    String startDateReality,
    int totalEmptySeat,
    int totalSeat,
    String tripId,
    String scheduleId,
    int tripStatus,
    String vehicleTypeId,
    String vehicleTypeName,
    AdditionPrice additionPriceForUserType,
    Vehicle vehicle,
    ContractRepresentation contractRepresentation,
    Point pointDown,
    Point pointUp,
    double price,
    List<User> drivers,
    List<User> assistants,
    List<int> listLockTrip,
    String note,
  }) {
    if ((date == null || identical(date, this.date)) &&
        (planId == null || identical(planId, this.planId)) &&
        (route == null || identical(route, this.route)) &&
        (runTime == null || identical(runTime, this.runTime)) &&
        (seatMap == null || identical(seatMap, this.seatMap)) &&
        (startTime == null || identical(startTime, this.startTime)) &&
        (startTimeReality == null ||
            identical(startTimeReality, this.startTimeReality)) &&
        (startDateReality == null ||
            identical(startDateReality, this.startDateReality)) &&
        (totalEmptySeat == null ||
            identical(totalEmptySeat, this.totalEmptySeat)) &&
        (totalSeat == null || identical(totalSeat, this.totalSeat)) &&
        (tripId == null || identical(tripId, this.tripId)) &&
        (scheduleId == null || identical(scheduleId, this.scheduleId)) &&
        (tripStatus == null || identical(tripStatus, this.tripStatus)) &&
        (vehicleTypeId == null ||
            identical(vehicleTypeId, this.vehicleTypeId)) &&
        (vehicleTypeName == null ||
            identical(vehicleTypeName, this.vehicleTypeName)) &&
        (additionPriceForUserType == null ||
            identical(
                additionPriceForUserType, this.additionPriceForUserType)) &&
        (vehicle == null || identical(vehicle, this.vehicle)) &&
        (contractRepresentation == null ||
            identical(contractRepresentation, this.contractRepresentation)) &&
        (pointDown == null || identical(pointDown, this.pointDown)) &&
        (pointUp == null || identical(pointUp, this.pointUp)) &&
        (price == null || identical(price, this.price)) &&
        (drivers == null || identical(drivers, this.drivers)) &&
        (assistants == null || identical(assistants, this.assistants)) &&
        (listLockTrip == null || identical(listLockTrip, this.listLockTrip)) &&
        (note == null || identical(note, this.note))) {
      return this;
    }

    return Trip(
      date: date ?? this.date,
      planId: planId ?? this.planId,
      route: route ?? this.route,
      runTime: runTime ?? this.runTime,
      seatMap: seatMap ?? this.seatMap,
      startTime: startTime ?? this.startTime,
      startTimeReality: startTimeReality ?? this.startTimeReality,
      startDateReality: startDateReality ?? this.startDateReality,
      totalEmptySeat: totalEmptySeat ?? this.totalEmptySeat,
      totalSeat: totalSeat ?? this.totalSeat,
      tripId: tripId ?? this.tripId,
      scheduleId: scheduleId ?? this.scheduleId,
      tripStatus: tripStatus ?? this.tripStatus,
      vehicleTypeId: vehicleTypeId ?? this.vehicleTypeId,
      vehicleTypeName: vehicleTypeName ?? this.vehicleTypeName,
      additionPriceForUserType:
          additionPriceForUserType ?? this.additionPriceForUserType,
      vehicle: vehicle ?? this.vehicle,
      contractRepresentation:
          contractRepresentation ?? this.contractRepresentation,
      pointDown: pointDown ?? this.pointDown,
      pointUp: pointUp ?? this.pointUp,
      price: price ?? this.price,
      drivers: drivers ?? this.drivers,
      assistants: assistants ?? this.assistants,
      listLockTrip: listLockTrip ?? this.listLockTrip,
      note: note ?? this.note,
    );
  }
}

@JsonSerializable(nullable: false)
class User {
  User({
    this.id,
    this.fullName,
    this.phoneNumber,
    this.avatar,
    this.stateCode,
    this.companyName,
    this.companyId,
  });

  factory User.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    return User(
      id: getString(Constant.id, data),
      fullName: getString(Constant.fullName, data),
      phoneNumber: getString(Constant.phoneNumber, data),
      avatar: getString(Constant.avatar, data),
      stateCode: getString(Constant.stateCode, data),
      companyName: getString(Constant.companyName, data),
      companyId: getString(Constant.companyId, data),
    );
  }

  final String id;
  final String fullName;
  final String phoneNumber;
  final String avatar;
  final String stateCode;
  final String companyName;
  final String companyId;

  User copyWith({
    String id,
    String fullName,
    String phoneNumber,
    String avatar,
    String stateCode,
    String companyName,
    String companyId,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (fullName == null || identical(fullName, this.fullName)) &&
        (phoneNumber == null || identical(phoneNumber, this.phoneNumber)) &&
        (avatar == null || identical(avatar, this.avatar)) &&
        (stateCode == null || identical(stateCode, this.stateCode)) &&
        (companyName == null || identical(companyName, this.companyName)) &&
        (companyId == null || identical(companyId, this.companyId))) {
      return this;
    }

    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      stateCode: stateCode ?? this.stateCode,
      companyName: companyName ?? this.companyName,
      companyId: companyId ?? this.companyId,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.id: id,
      Constant.fullName: fullName,
      Constant.phoneNumber: phoneNumber,
      Constant.avatar: avatar,
      Constant.stateCode: stateCode,
      Constant.companyName: companyName,
      Constant.companyId: companyId,
    };
  }
}

@JsonSerializable(nullable: false)
class Ticket {
  Ticket({
    this.ticketId,
    this.ticketCode,
    this.ticketStatus,
    this.createdDate,
    this.commission,
    this.tripId,
    this.scheduleId,
    this.getInTimePlan,
    this.getOffTimePlan,
    this.getInTimePlanInt,
    this.listSeatId,
    this.fullName,
    this.phoneNumber,
    this.routeId,
    this.paidMoney,
    this.pointUp,
    this.pointDown,
    this.agencyPrice,
    this.gotIntoTrip,
    this.isCompleted,
    this.note,
    this.companyId,
    this.company,
    this.tripStatus,
    this.overTime,
    this.seat,
    this.routeInfo,
    this.vehicle,
    this.isAdult,
    this.cashOnTheTrip,
    this.callStatus,
    this.image,
    this.originalTicketPrice,
    this.paymentType,
  });

  factory Ticket.fromJson(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    return Ticket(
      ticketId: getString(Constant.ticketId, data),
      ticketCode: getString(Constant.ticketCode, data),
      ticketStatus: getInt(Constant.ticketStatus, data),
      createdDate: getInt(Constant.createdDate, data),
      commission: getDouble(Constant.commission, data),
      tripId: getString(Constant.tripId, data),
      scheduleId: getString(Constant.scheduleId, data),
      getInTimePlan: getInt(Constant.getInTimePlan, data),
      getOffTimePlan: getInt(Constant.getOffTimePlan, data),
      getInTimePlanInt: getInt(Constant.getInTimePlanInt, data),
      listSeatId: getListString(Constant.listSeatId, data),
      fullName: getString(Constant.fullName, data),
      phoneNumber: getString(Constant.phoneNumber, data),
      routeId: getString(Constant.routeId, data),
      isAdult: getBool(Constant.isAdult, data),
      image: getString(Constant.image, data),
      paidMoney: getDouble(Constant.paidMoney, data),
      originalTicketPrice: getDouble(Constant.originalTicketPrice, data),
      pointUp: Point.fromMap(data[Constant.pointUp] as Map<String, dynamic>),
      pointDown:
          Point.fromMap(data[Constant.pointDown] as Map<String, dynamic>),
      agencyPrice: getDouble(Constant.agencyPrice, data),
      gotIntoTrip: getBool(Constant.gotIntoTrip, data),
      isCompleted: getBool(Constant.isCompleted, data),
      note: getString(Constant.note, data),
      companyId: getString(Constant.companyId, data),
      company: Company.fromJson(data[Constant.company] as Map<String, dynamic>),
      tripStatus: getInt(Constant.tripStatus, data),
      overTime: getInt(Constant.overTime, data),
      seat: Seat.fromMap(data[Constant.seat] as Map<String, dynamic>),
      routeInfo:
          RouteEntity.fromMap(data[Constant.routeInfo] as Map<String, dynamic>),
      vehicle: Vehicle.fromMap(data[Constant.vehicle] as Map<String, dynamic>),
      cashOnTheTrip: getDouble(Constant.cashOnTheTrip, data),
      callStatus: getInt(Constant.callStatus, data),
      paymentType: getInt(Constant.paymentType, data),
    );
  }

  final String ticketId;
  final String ticketCode;
  final bool isAdult;
  final int ticketStatus;
  final int createdDate;
  final double commission;
  final String tripId;
  final String scheduleId;
  final int getInTimePlan;
  final int getOffTimePlan;
  final int getInTimePlanInt; //ngay di dang yyyyMMdd
  final List<String> listSeatId;
  final String fullName;
  final String phoneNumber;
  final String routeId;
  final double paidMoney;
  final Point pointUp;
  final Point pointDown;
  final double agencyPrice;
  final double originalTicketPrice;
  final bool gotIntoTrip;
  final bool isCompleted;
  final String note;
  final String companyId;
  final Company company;
  final int tripStatus;
  final int overTime;
  final Seat seat;
  final RouteEntity routeInfo;
  final Vehicle vehicle;
  final double cashOnTheTrip;
  final int callStatus;
  final String image;
  final int paymentType;

  Ticket copyWith({
    String ticketId,
    String ticketCode,
    bool isAdult,
    int ticketStatus,
    int createdDate,
    double commission,
    String tripId,
    String scheduleId,
    int getInTimePlan,
    int getOffTimePlan,
    int getInTimePlanInt,
    List<String> listSeatId,
    String fullName,
    String phoneNumber,
    String routeId,
    double paidMoney,
    Point pointUp,
    Point pointDown,
    double agencyPrice,
    double originalTicketPrice,
    bool gotIntoTrip,
    bool isCompleted,
    String note,
    String companyId,
    Company company,
    int tripStatus,
    int overTime,
    Seat seat,
    RouteEntity routeInfo,
    Vehicle vehicle,
    double cashOnTheTrip,
    int callStatus,
    String image,
    int paymentType,
  }) {
    if ((ticketId == null || identical(ticketId, this.ticketId)) &&
        (ticketCode == null || identical(ticketCode, this.ticketCode)) &&
        (isAdult == null || identical(isAdult, this.isAdult)) &&
        (ticketStatus == null || identical(ticketStatus, this.ticketStatus)) &&
        (createdDate == null || identical(createdDate, this.createdDate)) &&
        (commission == null || identical(commission, this.commission)) &&
        (tripId == null || identical(tripId, this.tripId)) &&
        (scheduleId == null || identical(scheduleId, this.scheduleId)) &&
        (getInTimePlan == null ||
            identical(getInTimePlan, this.getInTimePlan)) &&
        (getOffTimePlan == null ||
            identical(getOffTimePlan, this.getOffTimePlan)) &&
        (getInTimePlanInt == null ||
            identical(getInTimePlanInt, this.getInTimePlanInt)) &&
        (listSeatId == null || identical(listSeatId, this.listSeatId)) &&
        (fullName == null || identical(fullName, this.fullName)) &&
        (phoneNumber == null || identical(phoneNumber, this.phoneNumber)) &&
        (routeId == null || identical(routeId, this.routeId)) &&
        (paidMoney == null || identical(paidMoney, this.paidMoney)) &&
        (pointUp == null || identical(pointUp, this.pointUp)) &&
        (pointDown == null || identical(pointDown, this.pointDown)) &&
        (agencyPrice == null || identical(agencyPrice, this.agencyPrice)) &&
        (originalTicketPrice == null ||
            identical(originalTicketPrice, this.originalTicketPrice)) &&
        (gotIntoTrip == null || identical(gotIntoTrip, this.gotIntoTrip)) &&
        (isCompleted == null || identical(isCompleted, this.isCompleted)) &&
        (note == null || identical(note, this.note)) &&
        (companyId == null || identical(companyId, this.companyId)) &&
        (company == null || identical(company, this.company)) &&
        (tripStatus == null || identical(tripStatus, this.tripStatus)) &&
        (overTime == null || identical(overTime, this.overTime)) &&
        (seat == null || identical(seat, this.seat)) &&
        (routeInfo == null || identical(routeInfo, this.routeInfo)) &&
        (vehicle == null || identical(vehicle, this.vehicle)) &&
        (cashOnTheTrip == null ||
            identical(cashOnTheTrip, this.cashOnTheTrip)) &&
        (callStatus == null || identical(callStatus, this.callStatus)) &&
        (paymentType == null || identical(paymentType, this.paymentType)) &&
        (image == null || identical(image, this.image))) {
      return this;
    }

    return Ticket(
      ticketId: ticketId ?? this.ticketId,
      ticketCode: ticketCode ?? this.ticketCode,
      isAdult: isAdult ?? this.isAdult,
      ticketStatus: ticketStatus ?? this.ticketStatus,
      createdDate: createdDate ?? this.createdDate,
      commission: commission ?? this.commission,
      tripId: tripId ?? this.tripId,
      scheduleId: scheduleId ?? this.scheduleId,
      getInTimePlan: getInTimePlan ?? this.getInTimePlan,
      getOffTimePlan: getOffTimePlan ?? this.getOffTimePlan,
      getInTimePlanInt: getInTimePlanInt ?? this.getInTimePlanInt,
      listSeatId: listSeatId ?? this.listSeatId,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      routeId: routeId ?? this.routeId,
      paidMoney: paidMoney ?? this.paidMoney,
      pointUp: pointUp ?? this.pointUp,
      pointDown: pointDown ?? this.pointDown,
      agencyPrice: agencyPrice ?? this.agencyPrice,
      originalTicketPrice: originalTicketPrice ?? this.originalTicketPrice,
      gotIntoTrip: gotIntoTrip ?? this.gotIntoTrip,
      isCompleted: isCompleted ?? this.isCompleted,
      note: note ?? this.note,
      companyId: companyId ?? this.companyId,
      company: company ?? this.company,
      tripStatus: tripStatus ?? this.tripStatus,
      overTime: overTime ?? this.overTime,
      seat: seat ?? this.seat,
      routeInfo: routeInfo ?? this.routeInfo,
      vehicle: vehicle ?? this.vehicle,
      cashOnTheTrip: cashOnTheTrip ?? this.cashOnTheTrip,
      callStatus: callStatus ?? this.callStatus,
      image: image ?? this.image,
      paymentType: paymentType ?? this.paymentType,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.ticketId: ticketId,
      Constant.ticketCode: ticketCode,
      Constant.ticketStatus: ticketStatus,
      Constant.createdDate: createdDate,
      Constant.commission: commission,
      Constant.tripId: tripId,
      Constant.scheduleId: scheduleId,
      Constant.getInTimePlan: getInTimePlan,
      Constant.getInTimePlanInt: getInTimePlanInt,
      Constant.listSeatId: json.encode(listSeatId),
      Constant.fullName: fullName,
      Constant.phoneNumber: phoneNumber,
      Constant.routeId: routeId,
      Constant.paidMoney: paidMoney,
      Constant.pointUp: pointUp.toJson(),
      Constant.pointDown: pointDown.toJson(),
      Constant.agencyPrice: agencyPrice,
      Constant.gotIntoTrip: gotIntoTrip,
      Constant.isCompleted: isCompleted,
      Constant.note: note,
      Constant.companyId: companyId,
      Constant.tripStatus: tripStatus,
      Constant.overTime: overTime,
      Constant.originalTicketPrice: originalTicketPrice,
      Constant.paymentType: paymentType,
      Constant.seatId: seat.toJson(),
      Constant.routeInfo: routeInfo.toJson(),
    };
  }
}

@JsonSerializable(nullable: false)
class Company {
  Company({
    this.id,
    this.name,
    this.phoneNumber,
    this.reputation,
    this.status,
    this.showTripToDriverAhead,
    this.isEditTicketPrice,
    this.isAllowedDriverToSeePrice,
  });

  factory Company.fromJson(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    return Company(
        id: data[Constant.id] == null
            ? getString(Constant.companyId, data)
            : getString(Constant.id, data),
        name: getString(Constant.name, data),
        phoneNumber: data[Constant.phoneNumber] == null
            ? getString(Constant.telecomPhoneNumber, data)
            : getString(Constant.phoneNumber, data),
        reputation: getDouble(Constant.reputation, data),
        status: getInt(Constant.status, data),
        showTripToDriverAhead: getInt(Constant.showTripToDriverAhead, data),
        isAllowedDriverToSeePrice:
            getBool(Constant.isAllowedDriverToSeePrice, data),
        isEditTicketPrice: getBool(Constant.isEditTicketPrice, data));
  }

  final String id;
  final String name;
  final String phoneNumber;
  final double reputation;
  final int status;
  final int showTripToDriverAhead;
  final bool isEditTicketPrice;
  final bool isAllowedDriverToSeePrice;

  Company copyWith({
    String id,
    String name,
    String phoneNumber,
    double reputation,
    int status,
    int showTripToDriverAhead,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (name == null || identical(name, this.name)) &&
        (phoneNumber == null || identical(phoneNumber, this.phoneNumber)) &&
        (reputation == null || identical(reputation, this.reputation)) &&
        (status == null || identical(status, this.status)) &&
        (showTripToDriverAhead == null ||
            identical(showTripToDriverAhead, this.showTripToDriverAhead))) {
      return this;
    }

    return Company(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      reputation: reputation ?? this.reputation,
      status: status ?? this.status,
      showTripToDriverAhead:
          showTripToDriverAhead ?? this.showTripToDriverAhead,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.id: id,
      Constant.name: name,
      Constant.phoneNumber: phoneNumber,
      Constant.reputation: reputation,
      Constant.status: status,
      Constant.showTripToDriverAhead: showTripToDriverAhead,
      Constant.isEditTicketPrice: isEditTicketPrice,
      Constant.isAllowedDriverToSeePrice: isAllowedDriverToSeePrice
    };
  }
}

@JsonSerializable(nullable: false)
class PointGroup {
  PointGroup({this.name, this.points, this.isExpanded});

  final String name;
  final List<Point> points;
  final bool isExpanded;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.name: name,
      Constant.points: json.encode(points),
      Constant.isExpanded: isExpanded,
    };
  }
}

class SearchTripParam {
  int page = 0;
  int count = 0;
  String startPoint = '';
  String endPoint = '';
  String date = ''; // co dang 20170303
  int searchPointOption = 0;
  int startTimeLimit = 0;
  int endTimeLimit = 86400000;
  String startPointName = '';
  String endPointName = '';
  String routeId = '';
  List<SortSelection> sortSelections = <SortSelection>[];
}

@JsonSerializable(nullable: false)
class SortSelection {
  SortSelection({this.fieldName, this.ascDirection});

  factory SortSelection.fromJson(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }
    return SortSelection(
      fieldName: getString(Constant.fieldName, map),
      ascDirection: getBool(Constant.ascDirection, map),
    );
  }

  final String fieldName;
  final bool ascDirection;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.fieldName: fieldName,
      Constant.ascDirection: ascDirection,
    };
  }
}

@JsonSerializable(nullable: false)
class TicketOption {
  TicketOption({
    this.ticketStatus,
    this.surcharges,
    this.images,
    this.seatId,
    this.fullName,
    this.phoneNumber,
    this.originalPrice,
    this.isAdult,
    this.extraPrice,
    this.agencyPrice,
    this.paymentTicketPrice,
    this.surcharge,
    this.ticketPrice,
    this.image,
    this.originTicketPrice,
    this.paidMoney,
    this.isTransshipment,
    this.pointUp,
    this.pointDown,
    this.promotionCode,
    this.note,
    this.email,
    this.dob,
    this.paymentType,
  });

  factory TicketOption.fromJson(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    return TicketOption(
      seatId: getString(Constant.seatId, data),
      fullName: getString(Constant.fullName, data),
      phoneNumber: getString(Constant.phoneNumber, data),
      originalPrice: getDouble(Constant.originalPrice, data),
      isAdult: getBool(Constant.isAdult, data),
      extraPrice: getDouble(Constant.extraPrice, data),
      agencyPrice: getDouble(Constant.agencyPrice, data),
      paymentTicketPrice: getDouble(Constant.paymentTicketPrice, data),
      surcharge: getDouble(Constant.surcharge, data),
      ticketPrice: getDouble(Constant.ticketPrice, data),
      image: getString(Constant.image, data),
      originTicketPrice: getDouble(Constant.originalPrice, data),
      paidMoney: getDouble(Constant.paidMoney, data),
      isTransshipment: getBool(Constant.isTransshipment, data),
      pointUp: Point.fromMap(data[Constant.pointUp] as Map<String, dynamic>),
      pointDown: Point.fromMap(data[Constant.pointUp] as Map<String, dynamic>),
      promotionCode: getString(Constant.promotionCode, data),
      note: getString(Constant.note, data),
      email: getString(Constant.email, data),
      dob: getString(Constant.dob, data),
      paymentType: getInt(Constant.paymentType, data),
      images: getListString(Constant.images, data),
      surcharges: getListSurcharge(Constant.surcharges, data),
      ticketStatus: getInt(Constant.ticketStatus, data),
    );
  }

  final String seatId;
  final String fullName;
  final String phoneNumber;
  final double originalPrice;
  final bool isAdult;
  final double extraPrice;
  final double agencyPrice;
  final double paymentTicketPrice;
  final double surcharge;
  final double ticketPrice;
  final String image;
  final double originTicketPrice;
  final double paidMoney;
  final bool isTransshipment;
  final Point pointUp;
  final Point pointDown;
  final String promotionCode;
  final String note;
  final String email;
  final String dob;
  final List<String> images;
  final int paymentType;
  final List<Surcharge> surcharges;
  final int ticketStatus;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.seatId: seatId,
      Constant.fullName: fullName,
      Constant.phoneNumber: phoneNumber,
      Constant.originalPrice: originalPrice,
      Constant.isAdult: isAdult,
      Constant.extraPrice: extraPrice,
      Constant.agencyPrice: agencyPrice,
      Constant.paymentTicketPrice: paymentTicketPrice,
      Constant.surcharge: surcharge,
      Constant.ticketPrice: ticketPrice,
      Constant.image: image,
      Constant.originTicketPrice: originTicketPrice,
      Constant.paidMoney: paidMoney,
      Constant.isTransshipment: isTransshipment,
      Constant.pointUp: pointUp.toJson(),
      Constant.pointDown: pointDown.toJson(),
      Constant.promotionCode: promotionCode,
      Constant.note: note,
      Constant.email: email,
      Constant.dob: dob,
      Constant.surcharges: surcharges,
      Constant.images: images,
      Constant.ticketStatus: ticketStatus,
    };
  }
}

@JsonSerializable(nullable: false)
class Advertisement {
  Advertisement({
    this.id,
    this.link,
    this.startDate,
    this.endDate,
    this.companyId,
    this.priority,
    this.isActive,
    this.createDate,
  });

  factory Advertisement.fromMap(Map<String, dynamic> data) {
    return Advertisement(
      id: getString(Constant.id, data),
      link: getString(Constant.link, data),
      startDate: getInt(Constant.startDate, data),
      endDate: getInt(Constant.endDate, data),
      companyId: getString(Constant.companyId, data),
      priority: getInt(Constant.priority, data),
      isActive: getBool(Constant.isActive, data),
      createDate: getInt(Constant.createDate, data),
    );
  }

  final String id;
  final String link;
  final int startDate;
  final int endDate;
  final String companyId;
  final int priority;
  final bool isActive;
  final int createDate;

  Advertisement copyWith({
    String id,
    String link,
    int startDate,
    int endDate,
    String companyId,
    int priority,
    bool isActive,
    int createDate,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (link == null || identical(link, this.link)) &&
        (startDate == null || identical(startDate, this.startDate)) &&
        (endDate == null || identical(endDate, this.endDate)) &&
        (companyId == null || identical(companyId, this.companyId)) &&
        (priority == null || identical(priority, this.priority)) &&
        (isActive == null || identical(isActive, this.isActive)) &&
        (createDate == null || identical(createDate, this.createDate))) {
      return this;
    }

    return Advertisement(
      id: id ?? this.id,
      link: link ?? this.link,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      companyId: companyId ?? this.companyId,
      priority: priority ?? this.priority,
      isActive: isActive ?? this.isActive,
      createDate: createDate ?? this.createDate,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.id: id,
      Constant.link: link,
      Constant.startDate: startDate,
      Constant.endDate: endDate,
      Constant.companyId: companyId,
      Constant.priority: priority,
      Constant.isActive: isActive,
      Constant.createDate: createDate,
    };
  }
}

@JsonSerializable(nullable: false)
class Surcharge {
  Surcharge({
    this.id,
    this.companyId,
    this.name,
    this.price,
    this.mode,
    this.active,
    this.createdDate,
    this.createdUser,
  });

  factory Surcharge.fromMap(Map<String, dynamic> data) {
    return Surcharge(
      id: getString(Constant.id, data),
      companyId: getString(Constant.companyId, data),
      name: getString(Constant.name, data),
      price: getDouble(Constant.price, data),
      mode: getInt(Constant.mode, data),
      active: getBool(Constant.active, data),
      createdDate: getInt(Constant.createdDate, data),
      createdUser:
          User.fromMap(data[Constant.createdUser] as Map<String, dynamic>),
    );
  }

  final String id;
  final String companyId;
  final String name;
  final double price;
  final int mode;
  final bool active;
  final int createdDate;
  final User createdUser;

  Surcharge copyWith({
    String id,
    String companyId,
    String name,
    double price,
    int mode,
    bool active,
    int createdDate,
    User createdUser,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (companyId == null || identical(companyId, this.companyId)) &&
        (name == null || identical(name, this.name)) &&
        (price == null || identical(price, this.price)) &&
        (mode == null || identical(mode, this.mode)) &&
        (active == null || identical(active, this.active)) &&
        (createdDate == null || identical(createdDate, this.createdDate)) &&
        (createdUser == null || identical(createdUser, this.createdUser))) {
      return this;
    }

    return Surcharge(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      name: name ?? this.name,
      price: price ?? this.price,
      mode: mode ?? this.mode,
      active: active ?? this.active,
      createdDate: createdDate ?? this.createdDate,
      createdUser: createdUser ?? this.createdUser,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.id: id,
      Constant.companyId: companyId,
      Constant.name: name,
      Constant.price: price,
      Constant.mode: mode,
      Constant.active: active,
      Constant.createdDate: createdDate,
      Constant.createdUser: createdUser != null ? createdUser.toJson() : null,
    };
  }
}

@JsonSerializable(nullable: false)
class GoodsCollect {
  GoodsCollect(
      {this.goodsList,
      this.routeId,
      this.tripStartDate,
      this.goodsStatus,
      this.routeName,
      this.goodsPackageName,
      this.tripId,
      this.goodsPackageCode});

  factory GoodsCollect.fromJson(final Map<String, dynamic> data) {
    if (data == null) {
      return GoodsCollect();
    }
    return GoodsCollect(
      routeId: getString(Constant.routeId, data),
      tripStartDate: getString(Constant.tripStartDate, data),
      goodsStatus: getInt(Constant.goodsStatus, data),
      routeName: getString(Constant.routeName, data),
      goodsPackageName: getString(Constant.goodsPackageName, data),
      tripId: getString(Constant.tripId, data),
      goodsPackageCode: getString(Constant.goodsPackageCode, data),
      goodsList: getListGoodsObject(Constant.goodsList, data),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.goodsList: goodsList,
      Constant.routeId: routeId,
      Constant.tripStartDate: tripStartDate,
      Constant.goodsStatus: goodsStatus,
      Constant.routeName: routeName,
      Constant.goodsPackageName: goodsPackageName,
      Constant.tripId: tripId,
      Constant.goodsPackageCode: goodsPackageCode,
    };
  }

  final String goodsPackageCode;
  final String goodsPackageName;
  final String tripId;
  final String routeId;
  final String tripStartDate;
  final int goodsStatus;
  final String routeName;
  final List<Goods> goodsList;
}

@JsonSerializable(nullable: false)
class Goods {
  Goods({
    this.goodsId,
    this.goodsCode,
    this.goodsTypeId,
    this.goodsName,
    this.dropPointId,
    this.dropOffPoint,
    this.dropOffPointName,
    this.receiver,
    this.receiverPhone,
    this.pickPointId,
    this.pickPointName,
    this.pickUpPoint,
    this.pickUpMidWay,
    this.sender,
    this.senderPhone,
    this.quantity,
    this.price,
    this.extraPrice,
    this.extraPriceNote,
    this.totalPrice,
    this.paid,
    this.unPaid,
    this.goodsValue,
    this.notice,
    this.sendDate,
    this.timeZone,
    this.sendSMS,
    this.dropMidWay,
    this.imageURL,
    this.receiverImageURL,
  });

  factory Goods.fromJson(final Map<String, dynamic> data) {
    if (data == null) {
      return Goods();
    }
    return Goods(
      goodsId: getString(Constant.goodsId, data),
      goodsCode: getString(Constant.goodsCode, data),
      goodsTypeId: getString(Constant.goodsTypeId, data),
      goodsName: getString(Constant.goodsName, data),
      dropPointId: getString(Constant.dropPointId, data),
      dropOffPoint: getString(Constant.dropOffPoint, data),
      dropOffPointName: getString(Constant.dropOffPointName, data),
      receiver: getString(Constant.receiver, data),
      receiverPhone: getString(Constant.receiverPhone, data),
      pickPointId: getString(Constant.pickPointId, data),
      pickPointName: getString(Constant.pickPointName, data),
      pickUpPoint: getString(Constant.pickUpPoint, data),
      pickUpMidWay: getBool(Constant.pickUpMidWay, data),
      sender: getString(Constant.sender, data),
      senderPhone: getString(Constant.senderPhone, data),
      quantity: getInt(Constant.quantity, data),
      price: getDouble(Constant.price, data),
      extraPrice: getDouble(Constant.extraPrice, data),
      extraPriceNote: getString(Constant.extraPriceNote, data),
      totalPrice: getDouble(Constant.totalPrice, data),
      paid: getDouble(Constant.paid, data),
      unPaid: getDouble(Constant.unPaid, data),
      goodsValue: getDouble(Constant.goodsValue, data),
      notice: getString(Constant.notice, data),
      sendDate: getInt(Constant.sendDate, data),
      timeZone: getInt(Constant.timeZone, data),
      sendSMS: getBool(Constant.sendSMS, data),
      dropMidWay: getBool(Constant.dropMidWay, data),
      imageURL: getString(Constant.imageURL, data),
      receiverImageURL: getString(Constant.receiverImageURL, data),
    );
  }

  Goods copyWith({
    String goodsId,
    String goodsCode,
    String goodsTypeId,
    String goodsName,
    String dropPointId,
    String dropOffPoint,
    String dropOffPointName,
    String receiver,
    String receiverPhone,
    String pickPointId,
    String pickPointName,
    String pickUpPoint,
    bool pickUpMidWay,
    String sender,
    String senderPhone,
    int quantity,
    double price,
    double extraPrice,
    String extraPriceNote,
    double totalPrice,
    double paid,
    double unPaid,
    double goodsValue,
    String notice,
    int sendDate,
    int timeZone,
    bool sendSMS,
    bool dropMidWay,
    String imageURL,
    String receiverImageURL,
    String goodsPackageCode,
    bool isExpanded,
  }) {
    return Goods(
      goodsId: goodsId ?? this.goodsId,
      goodsCode: goodsCode ?? this.goodsCode,
      goodsTypeId: goodsTypeId ?? this.goodsTypeId,
      goodsName: goodsName ?? this.goodsName,
      dropPointId: dropPointId ?? this.dropPointId,
      dropOffPoint: dropOffPoint ?? this.dropOffPoint,
      dropOffPointName: dropOffPointName ?? this.dropOffPointName,
      receiver: receiver ?? this.receiver,
      receiverPhone: receiverPhone ?? this.receiverPhone,
      pickPointId: pickPointId ?? this.pickPointId,
      pickPointName: pickPointName ?? this.pickPointName,
      pickUpPoint: pickUpPoint ?? this.pickUpPoint,
      pickUpMidWay: pickUpMidWay ?? this.pickUpMidWay,
      sender: sender ?? this.sender,
      senderPhone: senderPhone ?? this.senderPhone,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      extraPrice: extraPrice ?? this.extraPrice,
      extraPriceNote: extraPriceNote ?? this.extraPriceNote,
      totalPrice: totalPrice ?? this.totalPrice,
      paid: paid ?? this.paid,
      unPaid: unPaid ?? this.unPaid,
      goodsValue: goodsValue ?? this.goodsValue,
      notice: notice ?? this.notice,
      sendDate: sendDate ?? this.sendDate,
      timeZone: timeZone ?? this.timeZone,
      sendSMS: sendSMS ?? this.sendSMS,
      dropMidWay: dropMidWay ?? this.dropMidWay,
      imageURL: imageURL ?? this.imageURL,
      receiverImageURL: receiverImageURL ?? this.receiverImageURL,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.goodsId: goodsId,
      Constant.goodsCode: goodsCode,
      Constant.goodsTypeId: goodsTypeId,
      Constant.goodsName: goodsName,
      Constant.dropPointId: dropPointId,
      Constant.dropOffPoint: dropOffPoint,
      Constant.dropOffPointName: dropOffPointName,
      Constant.receiver: receiver,
      Constant.receiverPhone: receiverPhone,
      Constant.pickPointId: pickPointId,
      Constant.pickPointName: pickPointName,
      Constant.pickUpPoint: pickUpPoint,
      Constant.pickUpMidWay: pickUpMidWay,
      Constant.sender: sender,
      Constant.senderPhone: senderPhone,
      Constant.quantity: quantity,
      Constant.price: price,
      Constant.extraPrice: extraPrice,
      Constant.extraPriceNote: extraPriceNote,
      Constant.totalPrice: totalPrice,
      Constant.paid: paid,
      Constant.unPaid: unPaid,
      Constant.goodsValue: goodsValue,
      Constant.notice: notice,
      Constant.sendDate: sendDate,
      Constant.timeZone: timeZone,
      Constant.sendSMS: sendSMS,
      Constant.dropMidWay: dropMidWay,
      Constant.imageURL: imageURL,
      Constant.receiverImageURL: receiverImageURL,
    };
  }

  final String goodsId;
  final String goodsCode;
  final String goodsTypeId;
  final String goodsName;
  final String dropPointId;
  final String dropOffPoint;
  final String dropOffPointName;
  final String receiver;
  final String receiverPhone;
  final String pickPointId;
  final String pickPointName;
  final String pickUpPoint;
  final bool pickUpMidWay;
  final String sender;
  final String senderPhone;
  final int quantity;
  final double price;
  final double extraPrice;
  final String extraPriceNote;
  final double totalPrice;
  final double paid;
  final double unPaid;
  final double goodsValue;
  final String notice;
  final int sendDate;
  final int timeZone;
  final bool sendSMS;
  final bool dropMidWay;
  final String imageURL;
  final String receiverImageURL;
  String goodsPackageCode;
  bool isExpanded = false;
}

@JsonSerializable(nullable: false)
class Transshipment {
  Transshipment({
    this.ticketId,
    this.ticketCode,
    this.createdDateInt,
    this.tripId,
    this.getInTimePlanInt,
    this.scheduleId,
    this.companyId,
    this.fullName,
    this.phoneNumber,
    this.ticketStatus,
    this.pointUp,
    this.vehicle,
    this.callStatus,
    this.pointDown,
    this.getInTimePlan,
  });

  factory Transshipment.fromJson(final Map<String, dynamic> data) {
    if (data == null) {
      return Transshipment();
    }
    return Transshipment(
      phoneNumber: getString(Constant.phoneNumber, data),
      fullName: getString(Constant.fullName, data),
      ticketCode: getString(Constant.ticketCode, data),
      createdDateInt: getInt(Constant.createdDate, data),
      ticketStatus: getInt(Constant.ticketStatus, data),
      vehicle: Vehicle.fromMap(data[Constant.vehicle] as Map<String, dynamic>),
      companyId: getString(Constant.companyId, data),
      pointUp: Point.fromMap(data[Constant.pointUp] as Map<String, dynamic>),
      getInTimePlanInt: getInt(Constant.getInTimePlanInt, data),
      scheduleId: getString(Constant.scheduleId, data),
      ticketId: getString(Constant.ticketId, data),
      tripId: getString(Constant.tripId, data),
      callStatus: getInt(Constant.callStatus, data),
      pointDown:
          Point.fromMap(data[Constant.pointDown] as Map<String, dynamic>),
      getInTimePlan: getInt(Constant.getInTimePlan, data),
    );
  }

  final String ticketId;
  final String ticketCode;
  final int createdDateInt;
  final String tripId;
  final int getInTimePlanInt;
  final String scheduleId;
  final String companyId;
  final String fullName;
  final String phoneNumber;
  final int ticketStatus;
  final int callStatus;
  final Point pointUp;
  final Point pointDown;
  final Vehicle vehicle;
  final int getInTimePlan;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.ticketId: ticketId,
      Constant.ticketCode: ticketCode,
      Constant.createdDate: createdDateInt,
      Constant.tripId: tripId,
      Constant.getInTimePlanInt: getInTimePlanInt,
      Constant.scheduleId: scheduleId,
      Constant.companyId: companyId,
      Constant.fullName: fullName,
      Constant.phoneNumber: phoneNumber,
      Constant.ticketStatus: ticketStatus,
      Constant.pointUp: pointUp,
      Constant.vehicle: vehicle,
      Constant.callStatus: callStatus,
      Constant.pointDown: pointDown,
      Constant.getInTimePlan: getInTimePlan,
    };
  }
}

class TicketUser {
  TicketUser({this.fullName, this.phoneNumber, this.tickets});

  final String fullName;
  final String phoneNumber;
  final List<Ticket> tickets;
}

class TransshipmentTicket {
  TransshipmentTicket({this.fullName, this.phoneNumber, this.transshipment});

  final String fullName;
  final String phoneNumber;
  final List<Transshipment> transshipment;
}

@JsonSerializable(nullable: false)
class GoodsType {
  GoodsType({
    this.goodsTypeId,
    this.goodsTypeName,
    this.goodsPriceTableId,
    this.companyId,
    this.createdUserId,
    this.active,
    this.usePriceTable,
    this.createdDate,
    this.goodsTypePrice,
  });

  factory GoodsType.fromMap(Map<String, dynamic> data) {
    return GoodsType(
      goodsTypeId: getString(Constant.goodsTypeId, data),
      goodsTypeName: getString(Constant.goodsTypeName, data),
      goodsPriceTableId: getString(Constant.goodsPriceTableId, data),
      companyId: getString(Constant.companyId, data),
      createdUserId: getString(Constant.createdUserId, data),
      active: getBool(Constant.active, data),
      usePriceTable: getBool(Constant.usePriceTable, data),
      createdDate: getInt(Constant.createdDate, data),
      goodsTypePrice: getDouble(Constant.goodsTypePrice, data),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.goodsTypeId: goodsTypeId,
      Constant.goodsTypeName: goodsTypeName,
      Constant.goodsPriceTableId: goodsPriceTableId,
      Constant.companyId: companyId,
      Constant.createdUserId: createdUserId,
      Constant.active: active,
      Constant.usePriceTable: usePriceTable,
      Constant.createdDate: createdDate,
      Constant.goodsTypePrice: goodsTypePrice,
    };
  }

  GoodsType copyWith({
    String goodsTypeId,
    String goodsTypeName,
    String goodsPriceTableId,
    String companyId,
    String createdUserId,
    bool active,
    bool usePriceTable,
    int createdDate,
    double goodsTypePrice,
  }) {
    if ((goodsTypeId == null || identical(goodsTypeId, this.goodsTypeId)) &&
        (goodsTypeName == null ||
            identical(goodsTypeName, this.goodsTypeName)) &&
        (goodsPriceTableId == null ||
            identical(goodsPriceTableId, this.goodsPriceTableId)) &&
        (companyId == null || identical(companyId, this.companyId)) &&
        (createdUserId == null ||
            identical(createdUserId, this.createdUserId)) &&
        (active == null || identical(active, this.active)) &&
        (usePriceTable == null ||
            identical(usePriceTable, this.usePriceTable)) &&
        (createdDate == null || identical(createdDate, this.createdDate)) &&
        (goodsTypePrice == null ||
            identical(goodsTypePrice, this.goodsTypePrice))) {
      return this;
    }

    return GoodsType(
      goodsTypeId: goodsTypeId ?? this.goodsTypeId,
      goodsTypeName: goodsTypeName ?? this.goodsTypeName,
      goodsPriceTableId: goodsPriceTableId ?? this.goodsPriceTableId,
      companyId: companyId ?? this.companyId,
      createdUserId: createdUserId ?? this.createdUserId,
      active: active ?? this.active,
      usePriceTable: usePriceTable ?? this.usePriceTable,
      createdDate: createdDate ?? this.createdDate,
      goodsTypePrice: goodsTypePrice ?? this.goodsTypePrice,
    );
  }

  final String goodsTypeId;
  final String goodsTypeName;
  final String goodsPriceTableId;
  final String companyId;
  final String createdUserId;
  final bool active;
  final bool usePriceTable;
  final int createdDate;
  final double goodsTypePrice;
}

@JsonSerializable(nullable: false)
class ItemEntity {
  ItemEntity(
      {this.itemId,
      this.companyId,
      this.itemType,
      this.itemName,
      this.status,
      this.itemReceiptPayment,
      this.createDate,
      this.userId,
      this.description});

  factory ItemEntity.fromMap(Map<String, dynamic> data) {
    return ItemEntity(
      itemId: getString(Constant.itemId, data),
      companyId: getString(Constant.companyId, data),
      itemType: getInt(Constant.itemType, data),
      itemName: getString(Constant.itemName, data),
      status: getBool(Constant.status, data),
      itemReceiptPayment: getInt(Constant.itemReceiptPayment, data),
      createDate: getInt(Constant.createDate, data),
      userId: getString(Constant.userId, data),
      description: getString(Constant.description, data),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.itemId: itemId,
      Constant.companyId: companyId,
      Constant.itemType: itemType,
      Constant.itemName: itemName,
      Constant.status: status,
      Constant.itemReceiptPayment: itemReceiptPayment,
      Constant.createDate: createDate,
      Constant.userId: userId,
      Constant.description: description,
    };
  }

  final String itemId;
  final String companyId;
  final int itemType;
  final String itemName;
  final bool status;
  final int itemReceiptPayment;
  final int createDate;
  final String userId;
  final String description;
}

@JsonSerializable(nullable: false)
class BillEntity {
  BillEntity({
    this.id,
    this.companyId,
    this.documentCode,
    this.item,
    this.date,
    this.billType,
    this.spenderId,
    this.receiverId,
    this.approverId,
    this.isActive,
    this.tripId,
    this.amount,
    this.unit,
    this.createdDate,
    this.userId,
    this.number,
    this.havingIncrease,
    this.havingDecrease,
    this.reason,
    this.note,
    this.spender,
    this.receiver,
    this.numberPlate,
    this.realAmount,
    this.notedAmount,
    this.vehicleId,
    this.isInventoryingBill,
    this.price,
  });

  factory BillEntity.fromMap(Map<String, dynamic> data) {
    return BillEntity(
      id: getString(Constant.id, data),
      companyId: getString(Constant.companyId, data),
      documentCode: getString(Constant.documentCode, data),
      item: ItemEntity.fromMap(data[Constant.item] as Map<String, dynamic>),
      date: getInt(Constant.date, data),
      billType: getInt(Constant.billType, data),
      spenderId: getString(Constant.spenderId, data),
      receiverId: getString(Constant.receiverId, data),
      approverId: getString(Constant.approverId, data),
      isActive: getBool(Constant.isActive, data),
      tripId: getString(Constant.tripId, data),
      amount: getDouble(Constant.amount, data),
      unit: getString(Constant.unit, data),
      createdDate: getInt(Constant.createdDate, data),
      userId: getString(Constant.userId, data),
      number: getDouble(Constant.number, data).toInt(),
      havingIncrease: getDouble(Constant.havingIncrease, data).toInt(),
      havingDecrease: getDouble(Constant.havingDecrease, data).toInt(),
      reason: getString(Constant.reason, data),
      note: getString(Constant.note, data),
      spender: User.fromMap(data[Constant.spender] as Map<String, dynamic>),
      receiver: User.fromMap(data[Constant.receiver] as Map<String, dynamic>),
      numberPlate: getString(Constant.numberPlate, data),
      realAmount: getDouble(Constant.realAmount, data).toInt(),
      notedAmount: getString(Constant.notedAmount, data),
      vehicleId: getString(Constant.vehicleId, data),
      isInventoryingBill: getBool(Constant.isInventoryingBill, data),
      price: getDouble(Constant.price, data).toInt(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.id: id,
      Constant.companyId: companyId,
      Constant.documentCode: documentCode,
      Constant.item: item,
      Constant.date: date,
      Constant.billType: billType,
      Constant.spenderId: spenderId,
      Constant.receiverId: receiverId,
      Constant.approverId: approverId,
      Constant.isActive: isActive,
      Constant.tripId: tripId,
      Constant.amount: amount,
      Constant.unit: unit,
      Constant.createdDate: createdDate,
      Constant.userId: userId,
      Constant.number: number,
      Constant.havingIncrease: havingIncrease,
      Constant.havingDecrease: havingDecrease,
      Constant.reason: reason,
      Constant.note: note,
      Constant.spender: spender.toJson(),
      Constant.receiver: receiver.toJson(),
      Constant.numberPlate: numberPlate,
      Constant.realAmount: realAmount,
      Constant.notedAmount: notedAmount,
      Constant.vehicleId: vehicleId,
      Constant.isInventoryingBill: isInventoryingBill,
      Constant.price: price,
    };
  }

  final String id;
  final String companyId;
  final String documentCode;
  final ItemEntity item;
  final int date;
  final int billType;
  final String spenderId;
  final String receiverId;
  final String approverId;
  final bool isActive;
  final String tripId;
  final double amount;
  final String unit;
  final int createdDate;
  final String userId;
  final int number;
  final int havingIncrease;
  final int havingDecrease;
  final String reason;
  final String note;
  final User spender;
  final User receiver;
  final String numberPlate;
  final int realAmount;
  final String notedAmount;
  final String vehicleId;
  final bool isInventoryingBill;
  final int price;
}

class TotalInfo {
  TotalInfo( {this.user, this.company, this.telecomCompanies});

  factory TotalInfo.fromMap(Map<String, dynamic> data) {
    return TotalInfo(
      user: User.fromMap(data[Constant.userInfo] as Map<String, dynamic>),
      company: Company.fromJson(data[Constant.company] as Map<String, dynamic>),
      telecomCompanies: parseListTelecom(Constant.telecomCompanies, data ),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.userInfo: user.toJson(),
      Constant.company: company.toJson(),
      Constant.telecomCompanies: telecomCompanies
    };
  }

  TotalInfo copyWith({
    User user,
    Company company,
    List<TelecomCompany> telecomCompanies,
  }) {
    if ((user == null || identical(user, this.user)) &&
        (company == null || identical(company, this.company)) &&
        (telecomCompanies == null ||
            identical(telecomCompanies, this.telecomCompanies))) {
      return this;
    }

    return TotalInfo(
      user: user ?? this.user,
      company: company ?? this.company,
      telecomCompanies: telecomCompanies ?? this.telecomCompanies,
    );
  }

  final User user;
  final Company company;
  final List<TelecomCompany> telecomCompanies;
}

class Province {
  Province({this.name, this.regions});

  final String name;
  final List<RegionInfo> regions;
}

class UserLocation {
  UserLocation({this.longitude, this.latitude});

  final double longitude;
  final double latitude;

  UserLocation copyWith({
    double longitude,
    double latitude,
  }) {
    if ((longitude == null || identical(longitude, this.longitude)) &&
        (latitude == null || identical(latitude, this.latitude))) {
      return this;
    }

    return UserLocation(
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }
}

class TelecomCompany {
  TelecomCompany(
      {this.telecomCompanyId,
      this.telecomCompanyName,
      this.telecomType,
      this.telecomApiUrl});

  factory TelecomCompany.fromJson(Map<String, dynamic> data) {
    return TelecomCompany(
      telecomCompanyId: getString(Constant.telecomCompanyId, data),
      telecomCompanyName: getString(Constant.telecomCompanyName, data),
      telecomType: getInt(Constant.telecomType, data),
      telecomApiUrl: getString(Constant.telecomApiUrl, data),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.telecomCompanyId: telecomCompanyId,
      Constant.telecomCompanyName: telecomCompanyName,
      Constant.telecomType: telecomType,
      Constant.telecomApiUrl: telecomApiUrl
    };
  }

  TelecomCompany copyWith({
    String telecomCompanyId,
    String telecomCompanyName,
    int telecomType,
    String telecomApiUrl,
  }) {
    if ((telecomCompanyId == null ||
            identical(telecomCompanyId, this.telecomCompanyId)) &&
        (telecomCompanyName == null ||
            identical(telecomCompanyName, this.telecomCompanyName)) &&
        (telecomType == null || identical(telecomType, this.telecomType)) &&
        (telecomApiUrl == null ||
            identical(telecomApiUrl, this.telecomApiUrl))) {
      return this;
    }

    return TelecomCompany(
      telecomCompanyId: telecomCompanyId ?? this.telecomCompanyId,
      telecomCompanyName: telecomCompanyName ?? this.telecomCompanyName,
      telecomType: telecomType ?? this.telecomType,
      telecomApiUrl: telecomApiUrl ?? this.telecomApiUrl,
    );
  }

  final String telecomCompanyId;
  final String telecomCompanyName;
  final int telecomType;
  final String telecomApiUrl;
}

class RegionPageObject{
  RegionPageObject({this.regionList, this.boolMap, this.provinceValues, this.chosenRegions});
  final List<RegionInfo> regionList;
  final Map<String, List<bool>> boolMap;
  final List<bool> provinceValues;
  final List<RegionInfo> chosenRegions;
}
class PopUp{
  PopUp({this.id, this.link, this.startDate, this.endDate, this.priority});
  factory PopUp.fromJson(Map<String, dynamic> data) {
    return PopUp(
      id: getString(Constant.id, data),
      link: getString(Constant.link, data),
      startDate: getInt(Constant.startDate, data),
      endDate: getInt(Constant.endDate, data),
      priority: getInt(Constant.priority, data)
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.id: id,
      Constant.link: link,
      Constant.startDate: startDate,
      Constant.endDate: endDate,
      Constant.priority: priority
    };
  }

  PopUp copyWith({
    String id,
    String link,
    int startDate,
    int endDate,
    int priority,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (link == null || identical(link, this.link)) &&
        (startDate == null || identical(startDate, this.startDate)) &&
        (endDate == null || identical(endDate, this.endDate)) &&
        (priority == null || identical(priority, this.priority))) {
      return this;
    }

    return  PopUp(
      id: id ?? this.id,
      link: link ?? this.link,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      priority: priority ?? this.priority,
    );
  }

  final String id;
  final String link;
  final int startDate;
  final int endDate;
  final int priority;

}