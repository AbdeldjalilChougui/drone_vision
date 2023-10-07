import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:drone_vision/app/app.locator.dart';
import 'package:drone_vision/services/api_service.dart';
import 'package:drone_vision/services/token_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OtpViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _navigationService = locator<NavigationService>();
  final _tokenService = locator<TokenService>();
  bool? isClicked = false;
  bool? obscure = true;
  Timer? _timer;
  int start = 90;
  bool finished = false;
  String? startStr = '1:30';

  Future<String?> getLang() async {
    return await _tokenService.getLangValue();
  }

  updateObscure() {
    obscure = !obscure!;
    notifyListeners();
  }

  updateIsClicked({value}) {
    isClicked = value;
    notifyListeners();
  }

  back() {
    _navigationService.back();
  }

  void navigateTo({view}) {
    _navigationService.navigateWithTransition(view, curve: Curves.easeIn, duration: const Duration(milliseconds: 300));
  }

  void clearAndNavigateTo({view}) {
    _navigationService.clearStackAndShowView(view,);
  }

  setToken ({token}) {
    _tokenService.setTokenValue(token);
  }

  Future<bool?> requestResetPassword({Map<String, dynamic>? body, context}) async {
    // TODO treat timeout + connection out
    updateIsClicked(value: true);
    return await _apiService.requestResetPassword(
      context: context,
      body: body,
    ).catchError((e) {
      updateIsClicked(value: false);
    });
  }

  Future<bool?> resendRequestResetPassword({Map<String, dynamic>? body, context}) async {
    return await _apiService.requestResetPassword(
      context: context,
      body: body,
    );
  }

  void resendCode({body, context}) {
    resendRequestResetPassword(body: {'email' : body["email"]}, context: context);
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (start == 0) {
        timer.cancel();
        _timer!.cancel();
        finished = true;
        start = 90;
        startStr = '1:30';
        notifyListeners();
      } else {
        start--;
        if (start > 59) {
          if (start - 60 < 10) {
            startStr = "1:0${start - 60}";
          } else {
            startStr = "1:${start - 60}";
          }
        } else {
          if (start < 10) {
            startStr = "0:0$start";
          } else {
            startStr = "0:$start";
          }
        }
        notifyListeners();
      }
    },);
  }

  Future<bool?> setPassword({Map<String, dynamic>? body, context}) async {
    // TODO treat timeout + connection out
    updateIsClicked(value: true);
    return await _apiService.setPassword(
      body: body,
      context: context,
    ).catchError((e) {
      updateIsClicked(value: false);
    });
  }
}