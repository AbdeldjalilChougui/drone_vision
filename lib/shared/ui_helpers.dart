import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:fluttertoast/fluttertoast.dart';

const Widget horizontalSpaceTiny = SizedBox(width: 5.0);
const Widget horizontalSpaceSmall = SizedBox(width: 10.0);
const Widget horizontalSpaceRegular = SizedBox(width: 18.0);
const Widget horizontalSpaceMedium = SizedBox(width: 25.0);
const Widget horizontalSpaceLarge = SizedBox(width: 50.0);

const Widget verticalSpaceTiny = SizedBox(height: 5.0);
const Widget verticalSpaceSmall = SizedBox(height: 10.0);
const Widget verticalSpaceRegular = SizedBox(height: 18.0);
const Widget verticalSpaceMedium = SizedBox(height: 25.0);
const Widget verticalSpaceLarge = SizedBox(height: 50.0);

// Screen Size helpers

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightPercentage(BuildContext context, {double percentage = 1}) =>
    screenHeight(context) * percentage;

double screenWidthPercentage(BuildContext context, {double percentage = 1}) =>
    screenWidth(context) * percentage;

showMotionToast({BuildContext? context, String? title, String? msg, MotionToastType? type}) {
  if (type == MotionToastType.warning) {
    MotionToast.warning(
      title: title != null ? Text(title) : const SizedBox(),
      description: Text(msg!),
      animationCurve: Curves.easeIn,
      animationDuration: const Duration(milliseconds: 200),
    ).show(context!);
  } else if (type == MotionToastType.success) {
    MotionToast.success(
      title: title != null ? Text(title) : const SizedBox(),
      description: Text(msg!),
      animationCurve: Curves.easeIn,
      animationDuration: const Duration(milliseconds: 200),
    ).show(context!);
  } else if (type == MotionToastType.error) {
    MotionToast.error(
      title: title != null ? Text(title) : const SizedBox(),
      description: Text(msg!),
      animationCurve: Curves.easeIn,
      animationDuration: const Duration(milliseconds: 200),
    ).show(context!);
  } else if (type == MotionToastType.delete) {
    MotionToast.delete(
      title: title != null ? Text(title) : const SizedBox(),
      description: Text(msg!),
      animationCurve: Curves.easeIn,
      animationDuration: const Duration(milliseconds: 200),
    ).show(context!);
  } else {
    MotionToast.info(
      title: title != null ? Text(title) : const SizedBox(),
      description: Text(msg!),
      animationCurve: Curves.easeIn,
      animationDuration: const Duration(milliseconds: 200),
    ).show(context!);
  }
}

showSimpleToast() {
  Fluttertoast.showToast(
    msg: "Text copied",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.white,
    textColor: Colors.grey,
    fontSize: 16.0,
  );
}