import 'dart:convert';

import 'package:core_erp/controllers/apps/ecommerce/products_controller.dart';
import 'package:core_erp/controllers/auth/auth_controller.dart';
import 'package:core_erp/models/person.dart';
// import 'package:core_erp/models/http_responses.dart';

import 'package:core_erp/services/auth_service.dart';
import 'package:core_erp/services/localizations/language.dart';
import 'package:core_erp/services/theme/theme_customizer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

import '../../models/order.dart';

class LocalStorage {
  static const String _loggedInUserKey = "user";
  static const String _themeCustomizerKey = "theme_customizer";
  static const String _languageKey = "lang_code";

  static SharedPreferences? _preferencesInstance;

  static SharedPreferences get preferences {
    if (_preferencesInstance == null) {
      throw ("Call LocalStorage.init() to initialize local storage");
    }
    return _preferencesInstance!;
  }

  static Future<void> init() async {
    _preferencesInstance = await SharedPreferences.getInstance();
    await initData();
  }

  static Future<void> initData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    AuthService.isLoggedIn = preferences.getBool(_loggedInUserKey) ?? false;
    ThemeCustomizer.fromJSON(preferences.getString(_themeCustomizerKey));
    final authController = Get.put(AuthController());
    final productsController = Get.put(ProductsController());

    debugPrint(
        'SharedPreferences initData isLoggedIn ${AuthService.isLoggedIn} ');

    var authUser = await getAuthUser();
    var authToken = await getAuthToken();
    if (authUser != null) {
      debugPrint("authUser != null");
      authController.person.value = authUser;
      AuthService.authToken = authToken!;
      authController.authToken.value = authToken;
      authController.isLoggedIn.value =
          preferences.getBool(_loggedInUserKey) ?? false;
      authController.person.refresh();
      if (authUser.firstName != '' && authUser.accountType != '') {
        debugPrint('authUser.accountType==== ${authUser.accountType}');
        await productsController.getAccountOfferItems();
      }
    } else {
      debugPrint('No Stored User');
      authController.onHandleLogout();
    }
  }

  static Future<bool?> setAccountOrders(String orders) async {
    return preferences.setString('accountOrders', orders);
  }

  static Future<bool?> setCurrentSelectedOrder(String order) async {
    return preferences.setString('currentSelectedOrder', order);
  }

  static Future<Order?> getCurrentSelectedOrder() async {
    var storedData = preferences.getString("currentSelectedOrder");
    debugPrint('storedData ${storedData}');
    if (storedData != null) {
      final rawJson = preferences.getString("currentSelectedOrder");
      Map<String, dynamic> map = jsonDecode(rawJson!);
      Order order = Order.fromJson(map);
      return order;
    } else {
      return null;
    }
  }

  static Future<List<Order>?> getOrders() async {
    var storedData = preferences.getString("accountOrders");
    if (storedData != null) {
      List<Order> orders = jsonDecode(storedData);
      return orders;
    } else {
      return null;
    }
  }

  static Future<bool> setLoggedInUser(bool loggedIn) async {
    return preferences.setBool(_loggedInUserKey, loggedIn);
  }

  static Future<bool> setLoggedInUserData(String loggedInUser) async {
    debugPrint('setLoggedInUser ${loggedInUser}');

    preferences.setString("authUser", loggedInUser.toString());
    await preferences.setBool('isLoggedIn', true);
    return preferences.setBool(_loggedInUserKey, true);
  }
  static Future<bool> setLoggedInUserToken(String token) async {
    return preferences.setString("authToken", token);
  }

  static Future<String?> getAuthToken() async {
    var storedData = preferences.getString("authToken");
    if (storedData != null) {
      return storedData;
    } else {
      return null;
    }
  }

  static Future<Person?> getAuthUser() async {
    final rawJson = preferences.getString("authUser");
    if (rawJson != null) {
      Map<String, dynamic> map = jsonDecode(rawJson);
      final user = Person.fromJson(map);
      return user;
    }
    return null;
  }
  static Future<bool> setCustomizer(ThemeCustomizer themeCustomizer) {
    return preferences.setString(_themeCustomizerKey, themeCustomizer.toJSON());
  }



  static Future<Person?> getUserToken() async {
    var storedData = preferences.getString("authToken");
    try {
      if (storedData != null) {
        final decClaimSet = verifyJwtHS256Signature(storedData, "jwtKey");

        var claimPerson = decClaimSet['pld'];
        debugPrint('parsedJson: $claimPerson\n');
        var person = Person(
          createdDate: claimPerson['createdDate'],
          userID: claimPerson['userID'],
          firstName: claimPerson['firstName'],
          lastName: claimPerson['lastName'],
          phone: claimPerson['phone'],
          accountType: claimPerson['accountType'],
          tradingAs: claimPerson['tradingAs'],
          profileImage: claimPerson['profileImage'],
        );
        return person;
      } else {
        return null;
      }
    } catch (e) {
      Get.put(AuthController()).onHandleLogout();
      return null;
    }
  }

  static Future<bool> setProfileImageBytes(String imageBytes) async {
    debugPrint('setLoggedInUser ${imageBytes}');
    preferences.remove("profileImageBytes");
    return preferences.setString("profileImageBytes", imageBytes);
  }

  static Future<String?> getProfileImageBytes() async {
    var storedData = preferences.getString("profileImageBytes");
    if (storedData != null) {
      return storedData.toString();
    } else {
      return null;
    }
  }

  static Future<bool> removeLoggedInUser() async {
    await preferences.remove("authUser");
    await preferences.remove("authToken");
    await preferences.remove(_loggedInUserKey);
    var cleared = await preferences.clear();
    debugPrint('App Storage Cleared $cleared');

    return cleared;
  }

  static Future<bool> removeUserToken() async {
    return preferences.remove("authToken");
  }

  static Future<bool> setLanguage(Language language) {
    return preferences.setString(_languageKey, language.locale.languageCode);
  }

  static String? getLanguage() {
    return preferences.getString(_languageKey);
  }
}
