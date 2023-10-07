import 'package:flutter/material.dart';
import 'package:drone_vision/shared/colors.dart';

class ParametreItem extends StatelessWidget {
  const ParametreItem({
    super.key,
    this.label,
  });
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: kMainColor3, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label!, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
          Image.asset("assets/icons/back.png", height: 25),
        ],
      ),
    );
  }
}