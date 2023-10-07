import 'package:flutter/material.dart';
import 'package:drone_vision/shared/colors.dart';
import 'package:styled_widget/styled_widget.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    super.key,
    this.type,
  });

  final String? type;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: type == "all" ? BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kMainColor1),
      ) : type == "noBorder" ? BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ) : BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kMainColor1),
      ),
      child: Image.asset('assets/icons/back.png', height: 25,).center(),
    );
  }
}