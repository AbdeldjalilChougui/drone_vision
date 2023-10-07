import 'package:styled_widget/styled_widget.dart';
import 'package:flutter/material.dart';
import 'package:drone_vision/shared/colors.dart';
import 'package:drone_vision/shared/ui_helpers.dart';

class NavItem extends StatelessWidget {
  const NavItem({
    Key? key,
    required this.image,
    required this.isSelected,
    required this.onTap,
    required this.label,
  }) : super(key: key);

  final bool isSelected;
  final VoidCallback onTap;
  final String label;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: SizedBox(
          child: Column(
            children: [
              verticalSpaceTiny,
              Image.asset(image, color: isSelected ? Colors.white : kMainGray,),
              verticalSpaceTiny,
              Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.black,),)
            ],
          ),
        ).backgroundColor(isSelected ? kMainColor1 : Colors.white, animate: true)
            .animate(const Duration(milliseconds: 200), Curves.slowMiddle),
      ),
    );
  }
}