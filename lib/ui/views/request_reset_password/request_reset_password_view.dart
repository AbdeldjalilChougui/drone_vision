import 'package:drone_vision/ui/views/otp/otp_view.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:drone_vision/shared/colors.dart';
import 'package:drone_vision/shared/ui_helpers.dart';
import 'package:drone_vision/ui/views/request_reset_password/request_reset_password_viewmodel.dart';
import 'package:drone_vision/ui/widgets/back_button_widget.dart';
import 'package:drone_vision/ui/widgets/loader.dart';
import 'package:stacked/stacked.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RequestResetPasswordView extends HookWidget {
  const RequestResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var email = useTextEditingController();

    return ViewModelBuilder<RequestResetPasswordViewModel>.reactive(
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
                  const Text("Réinitialiser le mot de passe", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20)).center(),
                  verticalSpaceRegular,
                  const Text("Entrez votre email", style: TextStyle(color: Colors.white, fontSize: 15)),
                  SizedBox(
                    // height: 50,
                    child: TextFormField(
                      controller: email,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        hintText: '| ${"Entrez votre email"}',
                        hintStyle: const TextStyle(fontSize: 14, color: kGrayText),
                        fillColor: kMainColor3,
                        contentPadding: const EdgeInsets.all(1.0),
                        prefixIcon: Icon(Icons.email_outlined),
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
                  verticalSpaceLarge,
                  verticalSpaceLarge,
                  Container(
                    width: MediaQuery.of(context).size.width - 60,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: kMainColor1,
                    ),
                    child: Center(
                      child: model.isClicked! ? const Loader(color: Colors.white,).center() : Text('Suivant', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                    ),
                  ).gestures(
                    onTap: model.isClicked! ? () {} : () {
                      if (email.text.isEmpty) {
                        showMotionToast(
                          context: context,
                          type: MotionToastType.warning,
                          msg: "Enter your email first",
                        );
                      } else {
                        model.requestResetPassword(
                          context: context,
                          body: {"email": email.text,},
                        ).then((value) {
                          model.updateIsClicked(value: false);
                          if (value != null) {
                            model.navigateTo(view: OtpView(body: {"email": email.text,}));
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
      viewModelBuilder: () => RequestResetPasswordViewModel(),
    );
  }
}