import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_app/data/helper/app_exception.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// json encode details used to send data to api mobNo email etc
//bearer token always add in header
class ApiHelper {
  Future<dynamic> getApi({required String url, Map<String, String>? mHeaders}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";
    mHeaders ??= {};
    mHeaders["Authorization"] = "Bearer $token";
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: mHeaders,
      );
      return handleResponse(res: response);
    } on SocketException catch (e) {
      throw NoInternetException(msg: e.toString());
    }
  }

  Future<dynamic> postApi({
    required String url,
    Map<String, dynamic>? details,
    bool isAuth = false,
    Map<String, String>? mHeaders,
  }) async {
    ///jab login hoga tab token create hoga to aagar hum login
    ///kr rhe he token wla kaam na ho kuki account login karne se token create hoga
    ///warna koi aur post api call ho to token wla kaam hoo kuki
    ///token se hum cheez acces kar painge in case of login and signup
    ///isAuth wla kaam na ho
    if (!isAuth) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token") ?? "";
      mHeaders ??= {};
      mHeaders["Authorization"] = "Bearer $token";
    }

    try {
      http.Response response = await http.post(
        Uri.parse(url),
        headers: mHeaders,
        body: jsonEncode(details),
      );
      return handleResponse(res: response);
    } on SocketException catch (e) {
      throw NoInternetException(msg: e.toString());
    }
  }

  dynamic handleResponse({required http.Response res}) {
    switch (res.statusCode) {
      case 200:
        //success case
        return jsonDecode(res.body);
      case 400:
        //bad request
        throw BadRequestException(msg: res.body.toString());
      case 401:
        //unauthorized
        throw UnauthorizedException(msg: res.body.toString());
      case 404:
        //not found
        throw InvalidInputException(msg: res.body.toString());
      case 500:
      case 502:
      default:
        throw FetchDataException(msg: res.body.toString());
    }
  }
}
