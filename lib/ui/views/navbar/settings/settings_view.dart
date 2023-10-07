
import 'package:flutter/material.dart';
import 'package:drone_vision/shared/colors.dart';
import 'package:drone_vision/shared/ui_helpers.dart';
import 'package:drone_vision/ui/views/navbar/settings/settings_viewmodel.dart';
import 'package:drone_vision/ui/widgets/loader.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:drone_vision/ui/widgets/parametre_item.dart';

class SettingsView extends HookWidget {
  const SettingsView({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              verticalSpaceLarge,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40,),
                  const Text('Paramètres', style: kTitleStyle,).center(),
                  const SizedBox(width: 40,),
                ],
              ),
              verticalSpaceLarge,
              const ParametreItem(label: "Gérer mon profile").gestures(onTap: () => model.navigateTo()),
              verticalSpaceSmall,
              const ParametreItem(label: "Mes informations").gestures(onTap: () => model.navigateTo()),
              verticalSpaceSmall,
              const ParametreItem(label: "Nous contacter").gestures(onTap: () => model.navigateTo()),
              verticalSpaceSmall,
              const ParametreItem(label: "Conditions generales").gestures(onTap: () => model.navigateTo()),
              verticalSpaceSmall,
              const ParametreItem(label: "Politique de confidentialité").gestures(onTap: () => model.navigateTo()),
              verticalSpaceLarge,
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout),
                    horizontalSpaceSmall,
                    model.isClicked! ? const Loader().center() : const Text('Logout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),).center(),
                  ],
                ),
              ).gestures(onTap: () {
                model.logout(context: context).then((value) {
                  model.updateIsClicked(value: false);
                });
              }),
              verticalSpaceLarge,
            ],
          ).padding(horizontal: 20),
        ),
      ),
      viewModelBuilder: () => SettingsViewModel(context: context),
    );
  }
}