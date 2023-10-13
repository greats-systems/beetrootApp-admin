import 'package:core_erp/models/person.dart';
import 'package:core_erp/models/user.dart';
import 'package:core_erp/services/storage/local_storage.dart';

class AuthService {
  static bool isLoggedIn = false;
  static String authToken = 'admin';
  static String accountType = 'admin';
  static Person authUser = Person(
      firstName: 'firstName',
      lastName: 'lastName',
      phone: 'phone',
      accountType: 'accountType');

  static User get dummyUser =>
      User(-1, "admin@umojaxc.io", "Denish", "Navadiya");

  static Future<Map<String, String>?> loginUser(
      Map<String, dynamic> data) async {
    await Future.delayed(Duration(seconds: 1));
    if (data['email'] != dummyUser.email) {
      return {"email": "This email is not registered"};
    } else if (data['password'] != "1234567") {
      return {"password": "Password is incorrect"};
    }

    isLoggedIn = true;
    await LocalStorage.setLoggedInUser(true);
    return null;
  }

  static Future<String?> getAuthToken() async {
    await Future.delayed(Duration(seconds: 1));
    var token = await LocalStorage.getAuthToken();
    if (token != null) {
      authToken = token;
    }
    return authToken;
  }

  static Future<String?> getAuthUserAccountType() async {
    await Future.delayed(Duration(seconds: 1));
    var user = await LocalStorage.getAuthUser();
    if (user != null) {
      authUser = user;
      accountType = authUser.accountType!;
    }
    return accountType;
  }
}
