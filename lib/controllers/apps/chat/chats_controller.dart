import 'package:core_erp/controllers/main_controller.dart';
import 'package:core_erp/models/chat.dart';
import 'package:flutter/material.dart';

class ChatsController extends MainController {
  List<Chat> chats = [];

  ChatsController();

  TextEditingController message = TextEditingController();

  @override
  onInit() async {
    super.onInit();
    Chat.dummyList.then((value) {
      chats = value.sublist(0, 10);
      update();
    });
  }

  @override
  String getTag() {
    return "chats_controller";
  }
}
