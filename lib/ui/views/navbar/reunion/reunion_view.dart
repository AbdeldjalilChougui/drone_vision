
import 'package:flutter/material.dart';
import 'package:drone_vision/shared/colors.dart';
import 'package:drone_vision/shared/ui_helpers.dart';
import 'package:drone_vision/ui/views/navbar/reunion/reunion_viewmodel.dart';
import 'package:drone_vision/ui/widgets/creation_aware_item.dart';
import 'package:drone_vision/ui/widgets/loader.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

class ReunionView extends HookWidget {
  const ReunionView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReunionViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: const BottomAppBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(
              height: double.maxFinite,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  verticalSpaceMedium,
                  Row(
                    children: [
                      Column(
                        children: [
                          Text('Envoyée', style: TextStyle(
                            color: model.indexTab == 1 ? kMainColor1 : kGrayText,
                            fontWeight: model.indexTab == 1 ? FontWeight.w600 : FontWeight.w400
                          ),),
                          Divider(
                            height: 15,
                            thickness: model.indexTab == 1 ? 2 : 1.2,
                            color: model.indexTab == 1 ? kMainColor1 : kGrayText,
                          ),
                        ],
                      ).width(screenWidthPercentage(context, percentage: 0.5) - 20).gestures(
                        onTap: () => model.changeTab(1),
                      ),
                      Column(
                        children: [
                          Text('Reçu', style: TextStyle(
                            color: model.indexTab == 2 ? kMainColor1 : kGrayText,
                            fontWeight: model.indexTab == 2 ? FontWeight.w600 : FontWeight.w400,
                          ),),
                          Divider(
                            height: 15,
                            thickness: model.indexTab == 2 ? 2 : 1.2,
                            color: model.indexTab == 2 ? kMainColor1 : kGrayText,
                          ),
                        ],
                      ).width(screenWidthPercentage(context, percentage: 0.5) - 20).gestures(
                        onTap: () => model.changeTab(2),
                      ),
                    ],
                  ),
                  verticalSpaceMedium,

                  verticalSpaceMedium,
                ],
              ),
            ),
          )
        ),
      ),
      viewModelBuilder: () => ReunionViewModel(),
    );
  }
}