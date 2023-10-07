import 'package:styled_widget/styled_widget.dart';
import 'package:flutter/material.dart';

class RoundIconWidget extends StatelessWidget {
  const RoundIconWidget({
    super.key,
    this.image,
  });
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            spreadRadius: 0,
            blurRadius: 12,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Image.asset(image!).center(),
    );
  }
}