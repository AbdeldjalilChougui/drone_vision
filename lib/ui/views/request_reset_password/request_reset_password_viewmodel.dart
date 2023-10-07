import 'package:flutter/animation.dart';
import 'package:drone_vision/app/app.locator.dart';
import 'package:drone_vision/services/api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class RequestResetPasswordViewModel extends BaseViewModel {
  final _apiService = locator<ApiService>();
  final _navigationService = locator<NavigationService>();
  bool? isClicked = false;

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
}