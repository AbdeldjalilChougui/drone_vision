import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:drone_vision/app/app.locator.dart';

class EtapeViewModel extends BaseViewModel {
  EtapeViewModel({this.context});
  BuildContext? context;

  final _navigationService = locator<NavigationService>();

  navigateTo({view}) {
    _navigationService.navigateWithTransition(view);
  }
}