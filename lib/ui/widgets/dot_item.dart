import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:drone_vision/shared/colors.dart';

class DotItem extends StatelessWidget {
  const DotItem({
    Key? key,
    this.condition,
  }) : super(key: key);
  final bool? condition;

  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(color: condition! ? kMainColor1 : Colors.white, borderRadius: BorderRadius.circular(10)),)
        .height(12)
        .width(12)
        .opacity(condition! ? 1 : 0.6, animate: true)
        .animate(const Duration(milliseconds: 200), Curves.easeIn);
  }
}