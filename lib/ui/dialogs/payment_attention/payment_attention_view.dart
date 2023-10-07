
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:drone_vision/shared/colors.dart';
import 'package:drone_vision/shared/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';

class PaymentAttentionView extends HookWidget {
  const PaymentAttentionView({Key? key, required this.request, required this.completer})
      : super(key: key);

  final DialogRequest request;
  final Function(DialogResponse) completer;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18),),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            verticalSpaceSmall,
            Image.asset("assets/icons/payment.png"),
            verticalSpaceSmall,
            Text(request.data!, style: const TextStyle(color: kMainGray), textAlign: TextAlign.center,).center(),
            verticalSpaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: screenWidthPercentage(context, percentage: 0.3),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    border: Border.all(color: kMainColor1),
                  ),
                  child: Center(
                    child: Text('Plus tard', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                  ),
                ).gestures(
                  onTap: () {
                    completer(DialogResponse(confirmed: false));
                  },
                ),
                Container(
                  width: screenWidthPercentage(context, percentage: 0.3),
                  height: 50,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: kMainColor1,
                  ),
                  child: Center(
                    child: Text('Premium', style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),),
                  ),
                ).gestures(
                  onTap: () {
                    completer(DialogResponse(confirmed: true));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}