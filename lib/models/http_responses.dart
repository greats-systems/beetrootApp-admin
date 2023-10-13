import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get_connect/connect.dart';

class ResponseBody {
  late int? status;
  final String data;
  final bool? error;
  final String? errorMessage;
  final String? successMessage;

  ResponseBody({
    required this.status,
    required this.data,
    required this.error,
    required this.errorMessage,
    required this.successMessage,
  });
}

class OTP {
  final String? otp;
  final String? phone;

  OTP({
    required this.otp,
    required this.phone,
  });
}

class LoginDTO {
  final String? otp;
  final String? phone;
  final String? email;
  final String? password;

  LoginDTO({
    this.otp,
    this.phone,
    this.email,
    this.password,
  });
}

class SocketMessage {
  final String? reciever;
  final String? sender;
  final String? data;

  SocketMessage({
    this.reciever,
    this.sender,
    this.data,
  });
}

class ProfileImage {
  final String? filename;

  ProfileImage({
    this.filename,
  });
}

decodeOTP(ResponseBody responseBody) async {
  var jSonData = jsonDecode(responseBody.data);
  OTP otp = OTP(otp: jSonData['otp'], phone: jSonData['phone']);
  return otp;
}

decodeProfileImage(data) async {
  ProfileImage profileImage = ProfileImage(
    // path: data['path'],
    filename: data['filename'],
  );
  // debugPrint('decodeOfferItemImage offerItemImage  $profileImage');

  return profileImage;
}

processHttpResponse(Response<dynamic> response) async {
  // debugPrint('processHttpResponse response  ${response.body}');
  Response responseData = Response(body: response.body);

  // debugPrint('processHttpResponse responseData  ${responseData.body}');

  ResponseBody responseBody = ResponseBody(
      status: responseData.body['status'],
      data: responseData.body['data'],
      error: responseData.body['err'],
      errorMessage: responseData.body['errorMessage'],
      successMessage: responseData.body['successMessage']);
  // debugPrint('processHttpResponse responseBody data ${responseBody.data}');

  return responseBody;
}

String formatDateTime(DateTime dateTime) {
  String day = dateTime.day.toString().padLeft(2, '0');
  String month = getMonthName(dateTime.month);
  String year = dateTime.year.toString();
  String time =
      "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

  return "$day $month $year, $time";
}

String getMonthName(int month) {
  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  return months[month - 1];
}
