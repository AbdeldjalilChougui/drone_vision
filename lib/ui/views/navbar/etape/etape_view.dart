
import 'package:flutter/material.dart';
import 'package:drone_vision/shared/ui_helpers.dart';
import 'package:drone_vision/ui/views/navbar/etape/etape_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:styled_widget/styled_widget.dart';

class EtapeView extends HookWidget {
  const EtapeView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EtapeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Column(
              children: [
                verticalSpaceLarge,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Les Étapes pour utiliser l'application", style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17),).width(screenWidthPercentage(context, percentage: 0.8)),
                    const SizedBox(width: 40,),
                  ],
                ),
                verticalSpaceRegular,
              ],
            ).padding(horizontal: 20),
          ),
        ),
      ),
      viewModelBuilder: () => EtapeViewModel(context: context),
    );
  }
}