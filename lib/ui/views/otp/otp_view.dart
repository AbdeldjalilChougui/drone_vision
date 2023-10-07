import 'package:flutter/material.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:drone_vision/shared/colors.dart';
import 'package:drone_vision/shared/ui_helpers.dart';
import 'package:drone_vision/ui/views/login/login_view.dart';
import 'package:drone_vision/ui/views/otp/otp_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pinput/pinput.dart';
import 'package:drone_vision/ui/widgets/back_button_widget.dart';

class OtpView extends HookWidget {
  const OtpView({Key? key, this.body}) : super(key: key);
  final Map<String, dynamic>? body;

  @override
  Widget build(BuildContext context) {
    var password = useTextEditingController();
    var rePassword = useTextEditingController();
    final codeController = useTextEditingController();
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(
        fontSize: 32,
      ),
      decoration: BoxDecoration(
        color: kMainDisabledGray,
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return ViewModelBuilder<OtpViewModel>.reactive(
      builder: (context, model, child) => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          body: SafeArea(
            child: Container(
              height: screenHeightPercentage(context, percentage: 1),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: [
                  verticalSpaceLarge,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BackButtonWidget(type: "noBorder").gestures(onTap: () => model.back(),),
                      const SizedBox(width: 40),
                    ],
                  ),
                  verticalSpaceSmall,
                  const Text("Code de vérification.", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)).center(),
                  verticalSpaceRegular,
                  const Text("Un code a été envoyé à votre numéro de téléphone.", style: TextStyle(color: Colors.white, fontSize: 15)),
                  verticalSpaceRegular,
                  Pinput(
                    controller: codeController,
                    length: 6,
                    defaultPinTheme: defaultPinTheme,
                    onCompleted: (code) {},
                  ),
                  verticalSpaceMedium,
                  const Row(
                    children: [
                      horizontalSpaceSmall,
                      Text("Nouveau mot de passe", style: kWhiteStyle,),
                    ],
                  ),
                  SizedBox(
                    // height: 50,
                    child: TextFormField(
                      controller: password,
                      obscureText: model.obscure!,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: '| ${"Entrez votre mot de passe"}',
                        hintStyle: const TextStyle(fontSize: 14, color: kGrayText),
                        fillColor: kMainColor3,
                        contentPadding: const EdgeInsets.all(1.0),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Icon(Icons.remove_red_eye).gestures(
                          onTap: () => model.updateObscure(),
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
                  verticalSpaceSmall,
                  const Row(
                    children: [
                      horizontalSpaceSmall,
                      Text("Confirmer mot de passe", style: kWhiteStyle,),
                    ],
                  ),
                  SizedBox(
                    // height: 50,
                    child: TextFormField(
                      controller: rePassword,
                      obscureText: model.obscure!,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: '| ${"Confirmer mot de passe"}',
                        hintStyle: const TextStyle(fontSize: 14, color: kGrayText),
                        fillColor: kMainColor3,
                        contentPadding: const EdgeInsets.all(1.0),
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: Icon(Icons.remove_red_eye).gestures(
                          onTap: () => model.updateObscure(),
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
                  verticalSpaceSmall,
                  Text('${"Resend Code"} ${model.startStr}', style: TextStyle(color: model.start == 90 ? Colors.white : kMainColor3, fontWeight: FontWeight.w600),).gestures(onTap: () {
                    model.resendCode(body: body, context: context);
                  }),
                  verticalSpaceMedium,
                  Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: kMainColor1,
                    ),
                    child: const Center(
                      child : Text('Vérifier', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                    ),
                  ).gestures(
                    onTap: () {
                      if (password.text.isNotEmpty && rePassword.text.isNotEmpty && codeController.text.isNotEmpty && codeController.text.length == 6) {
                        if (password.text != rePassword.text) {
                          showMotionToast(
                            context: context,
                            type: MotionToastType.warning,
                            msg: "Password and confirmation password does not match, try again",
                          );
                        } else {
                          body!['password'] = password.text;
                          body!['otp'] = codeController.text;
                          model.setPassword(body: body!, context: context).then((value) async {
                            model.updateIsClicked(value: false);
                            if (value!) {
                              String? lang = await model.getLang();
                              model.navigateTo(view: LoginView(lang: lang,));
                            }
                          });
                        }
                      } else {
                        showMotionToast(
                          context: context,
                          type: MotionToastType.warning,
                          msg: "All fields are mandatory, fill all missing fields",
                        );
                      }
                    }
                  ),
                  verticalSpaceMedium,
                ],
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => OtpViewModel(),
    );
  }
}
