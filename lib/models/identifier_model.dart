import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:core_erp/models/http_responses.dart';
import 'package:core_erp/models/model.dart';

abstract class IdentifierModel<T> extends Model {
  final int id;

  IdentifierModel(this.id);
}

processHttpResponse(Response<dynamic> response) async {
  Response responseData = Response(body: response.body);
  // debugPrint('processHttpResponse responseData  ${responseData.body}');
  ResponseBody responseBody = ResponseBody(
      status: responseData.body['status'],
      data: responseData.body['data'],
      error: responseData.body['err'],
      errorMessage: responseData.body['errorMessage'],
      successMessage: responseData.body['successMessage']);
  return responseBody;
}
