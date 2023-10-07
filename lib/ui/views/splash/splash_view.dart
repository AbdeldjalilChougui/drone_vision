import 'package:flutter/material.dart';
import 'package:drone_vision/shared/ui_helpers.dart';
import 'package:drone_vision/ui/views/splash/splash_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:styled_widget/styled_widget.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: screenHeightPercentage(context, percentage: 1),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                  ).center()
                      .opacity(!model.isDone? 0.0 : 1.0, animate: true)
                      .animate(const Duration(milliseconds: 1000), Curves.easeIn),
                ],
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}
