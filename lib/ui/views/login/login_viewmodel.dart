import 'package:drone_vision/services/token_service.dart';
import 'package:flutter/animation.dart';
import 'package:drone_vision/app/app.locator.dart';
import 'package:drone_vision/services/api_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel({this.lang});
  String? lang;

  bool isObscure = true;
  final _apiService = locator<ApiService>();
  final _tokenService = locator<TokenService>();
  final _navigationService = locator<NavigationService>();
  bool? isClicked = false;

  updateLang({value}) {
    lang = value;
    notifyListeners();
  }

  updateIsClicked({value}) {
    isClicked = value;
    notifyListeners();
  }

  void changeObscure() {
    isObscure = !isObscure;
    notifyListeners();
  }

  void navigateTo({view}) {
    _navigationService.navigateWithTransition(view, curve: Curves.easeIn, duration: const Duration(milliseconds: 300));
  }

  void clearAndNavigateTo({view}) {
    _navigationService.clearStackAndShowView(view,);
  }

  Future<String?> login({Map<String, dynamic>? body,}) async {
    // TODO treat timeout + connection out
    // updateIsClicked(value: true);
    _tokenService.setTokenValue("tempFakeToke");
    return "";
    // return await _apiService.login(
    //   body: body,
    // ).catchError((e) {
    //   updateIsClicked(value: false);
    // });
  }
}