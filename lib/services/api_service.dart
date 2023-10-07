// ignore_for_file: depend_on_referenced_packages
import 'dart:async';
import 'dart:convert';

import 'package:drone_vision/app/app.locator.dart';
import 'package:drone_vision/models/drone_model.dart';
import 'package:drone_vision/services/token_service.dart';
import 'package:drone_vision/shared/app_configs.dart';
import 'package:drone_vision/shared/ui_helpers.dart';
import 'package:drone_vision/ui/views/splash/splash_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:motion_toast/resources/arrays.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class ApiService {
  final _navigationService = locator<NavigationService>();
  final _tokenService = locator<TokenService>();

  Future<WebSocketChannel?> webSocket({String? token}) async {
    final wsUrl = Uri.parse('ws://zwedj.com:8001/ws/?token=$token');
    var channel = IOWebSocketChannel.connect(
      wsUrl,
      protocols: {'http'},
      connectTimeout: const Duration(seconds: 10),
    );

    return channel;
  }

  Future<String?> login({Map? body}) async {
    return http.post(
      Uri.parse("$baseUrl/api/accounts/login/"),
      body: body,
    ).then((response) async {
      if (response.statusCode == 200) {
        _tokenService.setTokenValue(jsonDecode(utf8.decode(response.bodyBytes))['access']);
        return jsonDecode(utf8.decode(response.bodyBytes))['access'];
      } else {
        return null;
      }
    });
  }

  Future<bool?> requestResetPassword({Map? body, context}) async {
    return http.post(
      Uri.parse("$baseUrl/api/accounts/reset-password/get-otp/"),
      body: body,
    ).then((response) async {
      if (response.statusCode == 200) {
        return true;
      } else {
        showMotionToast(context: context, title: 'Request Reset password failed', msg: jsonDecode(utf8.decode(response.bodyBytes))["message"], type: MotionToastType.error);
        return null;
      }
    });
  }

  Future<bool?> setPassword({Map? body, context}) async {
    return http.post(
      Uri.parse("$baseUrl/api/accounts/reset-password/set-new-password/"),
      body: body,
    ).then((response) async {
      if (response.statusCode == 200) {
        return true;
      } else {
        showMotionToast(context: context, title: 'Reset password failed', msg: jsonDecode(utf8.decode(response.bodyBytes))["message"], type: MotionToastType.error);
        return false;
      }
    });
  }

  Future<List<DroneModel>?> getDrones({context, token}) async {
    return http.get(
        Uri.parse("$baseUrl/api/drones/"),
        headers: {
          "Authorization": "Bearer $token",
        }
    ).then((response) async {
      if (response.statusCode == 200) {
        List<DroneModel>? drones = [];
        for (var drone in jsonDecode(utf8.decode(response.bodyBytes))) {
          drones.add(DroneModel.fromJson(drone));
        }
        return drones;
      } else if (response.statusCode == 401) {
        unAuthClearAndRestart(context: context,);
        return null;
      } else {
        showMotionToast(context: context, msg: jsonDecode(utf8.decode(response.bodyBytes))["message"], type: MotionToastType.error);
        return null;
      }
    });
  }

  logout({context}) {
    showMotionToast(context: context!, type: MotionToastType.error, msg: "See you soon, Have a good day",);
    _tokenService.clearToken();
    Timer(const Duration(milliseconds: 1000), () {
      _navigationService.clearStackAndShowView(const SplashView());
    });
  }

  unAuthClearAndRestart({BuildContext? context}) {
    showMotionToast(context: context!, type: MotionToastType.error, msg: "Your session has expired, you must login again", title: 'Unauthorized');
    _tokenService.clearToken();
    Timer(const Duration(milliseconds: 1000), () {
      _navigationService.clearStackAndShowView(const SplashView());
    });
  }
}