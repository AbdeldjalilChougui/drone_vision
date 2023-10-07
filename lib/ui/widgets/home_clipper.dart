import 'package:flutter/cupertino.dart';

class HomeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();

    p.moveTo(0, 0);
    p.lineTo(0,size.height - 40);


    p.quadraticBezierTo(0, size.height, 40, size.height);

    p.lineTo(size.width, size.height);
    p.lineTo(size.width, 0);
    p.lineTo(0, 0);

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}