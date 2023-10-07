import 'dart:async';

import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:drone_vision/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ReunionViewModel extends BaseViewModel {

  final _navigationService = locator<NavigationService>();
  int indexTab = 1;
  int pageNumberIM = 1;
  int pageNumberRM = 1;

  void changeTab(int value) {
    indexTab = value;
    notifyListeners();
  }

  Future navigateTo({view}) async {
    await _navigationService.navigateWithTransition(view, curve: Curves.easeIn, duration: const Duration(milliseconds: 300));
  }
}