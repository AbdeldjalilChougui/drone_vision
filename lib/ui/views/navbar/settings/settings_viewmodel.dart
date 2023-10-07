import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:drone_vision/app/app.locator.dart';
import 'package:drone_vision/services/api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  SettingsViewModel({this.context});
  BuildContext? context;

  final _navigationService = locator<NavigationService>();
  final _apiService = locator<ApiService>();
  bool? isClicked = false;

  updateIsClicked({value}) {
    isClicked = value;
    notifyListeners();
  }

  void navigateTo({view}) {
    _navigationService.navigateWithTransition(view, curve: Curves.easeIn, duration: const Duration(milliseconds: 300));
  }

  Future<bool?> logout({context}) async {
    updateIsClicked(value: true);
    _apiService.logout(context: context);
    return true;
  }
}