import 'package:halan/base/constant.dart';

class URL {
  static const String baseURL = 'https://ticket-new-dot-dobody-anvui.appspot.com/';
  static const String uploadImage = baseURL+ 'image/upload';
  static const String getSchedule = baseURL + 'planfortrip/searchForCustomer';
  static const String getPopUp = baseURL+'popup/get-list';
  static const String getRouteList = baseURL+'route/getList';
  static const String getPopularRouteList = baseURL+'route/popular?companyId=${Constant.interBusLinesCompanyId}';
  static const String getOTPCode = baseURL+'user/sendOTP';
  static const String loginURL = baseURL+'user/login';
  static const String getListTicket = baseURL+'ticket/getForCustomer';
  static const String viewRoute = baseURL+'route/view';
  static const String getListTicketByUser = baseURL+'ticket/getListByUser';
  static const String checkPromotion = baseURL+'promotion/check';
  static const String checkTicketByCode = baseURL+ 'ticket/viewByCode';
  static const String generateQRCode = baseURL+ 'vnpay/qr/pay';
  static const String updateUserInfo = baseURL + '/user/updateinfo';
  static const String bookTicket = baseURL+'ticket/book';
  static const String sendOTPCall = baseURL+'checkmobi/send';
  static const String loginOTPCall = baseURL+'checkmobi/validate';
}
