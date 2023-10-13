import 'package:core_erp/controllers/main_controller.dart';
import 'package:flutter/material.dart';

class AuthLayoutController extends MainController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final scrollKey = GlobalKey();

  @override
  String getTag() {
    return "auth_layout_controller";
  }
}
