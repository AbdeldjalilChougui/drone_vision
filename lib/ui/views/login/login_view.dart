
import 'package:drone_vision/ui/views/request_reset_password/request_reset_password_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:drone_vision/shared/colors.dart';
import 'package:drone_vision/shared/ui_helpers.dart';
import 'package:drone_vision/ui/views/index/index_view.dart';
import 'package:drone_vision/ui/views/login/login_viewmodel.dart';
import 'package:drone_vision/ui/widgets/loader.dart';
import 'package:stacked/stacked.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginView extends HookWidget {
  const LoginView({Key? key, this.lang}) : super(key: key);
  final String? lang;

  @override
  Widget build(BuildContext context) {
    var email = useTextEditingController();
    var password = useTextEditingController();

    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: SafeArea(
            child: Container(
              height: screenHeightPercentage(context, percentage: 1),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        verticalSpaceLarge,
                        const Text("Login", style: TextStyle(color: kMainColor1, fontWeight: FontWeight.w700, fontSize: 25)).center(),
                        verticalSpaceRegular,
                        SizedBox(
                          // height: 50,
                          child: TextFormField(
                            controller: email,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: '| Enter Your User Name',
                              hintStyle: const TextStyle(fontSize: 14, color: Colors.black),
                              fillColor: kMainColor1.withOpacity(0.1),
                              contentPadding: const EdgeInsets.all(1.0),
                              prefixIcon: const Icon(CupertinoIcons.person, color: Colors.black),
                              filled: true,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: kMainColor1),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: kMainColor1),
                              ),
                            ),
                          ),
                        ),
                        verticalSpaceMedium,
                        SizedBox(
                          // height: 50,
                          child: TextFormField(
                            controller: password,
                            obscureText: model.isObscure,
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: '| Enter Your Password',
                              hintStyle: const TextStyle(fontSize: 14, color: Colors.black),
                              fillColor: kMainColor1.withOpacity(0.1),
                              contentPadding: const EdgeInsets.all(1.0),
                              prefixIcon: const Icon(Icons.lock, color: Colors.black),
                              suffixIcon: const Icon(Icons.remove_red_eye, color: Colors.black,).gestures(
                                onTap: () => model.changeObscure(),
                              ),
                              filled: true,
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: kMainColor1),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: kMainColor1),
                              ),
                            ),
                          ),
                        ),
                        verticalSpaceTiny,
                        const Text('Forgot Password?', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: kMainColor1),)
                            .alignment(Alignment.centerRight).gestures(onTap: () {
                          model.navigateTo(view: const RequestResetPasswordView());
                        }),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: kMainGradient,
                    ),
                    child: Center(
                      child: model.isClicked! ? const Loader(color: Colors.white,).center() : const Text('Suivant', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                    ),
                  ).gestures(
                    onTap: model.isClicked! ? () {} : () {
                      if (email.text.isEmpty || password.text.isEmpty) {
                        showMotionToast(
                          context: context,
                          type: MotionToastType.warning,
                          msg: "All fields are mandatory, fill all missing fields",
                        );
                      } else {
                        model.login().then((value) {
                          // model.updateIsClicked(value: false);
                          if (value != null) {
                            model.clearAndNavigateTo(view: const WebSocketListener());
                          } else {
                            showMotionToast(
                              context: context,
                              title: "Login Failed",
                              msg: "An error has occurred, please try again",
                              type: MotionToastType.warning,
                            );
                          }
                        });
                      }
                    },
                  ),
                  verticalSpaceMedium,
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => LoginViewModel(lang: lang),
    );
  }
}
