import 'package:flutter/material.dart';

const Color kMainColor1 = Color(0xff4C00EF);
const Color kMainColor2 = Color(0xffEFBB00);
const Color kMainColor3 = Color(0xffE8ECEB);
const Color kMainGray = Color(0xff808283);
const Color kMainDisabledGray = Color(0xffDDDDDD);
const Color kTextFiledMainColor = Color(0xfff3f7FB);
const Color kGrayText = Color(0xffD1D8D4);
const Color kBlueColor = Color(0xff0368FF);

const kMainGradient = LinearGradient(
  colors: [
    kMainColor1,
    kBlueColor,
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);

const kTitleStyle = TextStyle(fontWeight: FontWeight.w700, fontSize: 20);
const kTitleStyle2 = TextStyle(fontWeight: FontWeight.w700, fontSize: 16);
const kWhiteStyle = TextStyle(color: Colors.white);
const kMainStyle = TextStyle(color: kMainColor1);