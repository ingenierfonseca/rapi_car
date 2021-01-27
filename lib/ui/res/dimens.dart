import 'package:flutter/material.dart';
import 'package:rapi_car_app/ui/util/screen_util.dart';

double kMinSpace = 2.0.sw();
double kSmallSpace = 4.0.sw();
double kHalfSpace = 8.0.sw();
double kNormalSpace = 16.0.sw();
double kLargeSpace = 24.0.sw();
double kVeryLargeSpace = 32.0.sw();
double kTooLargeSpace = 64.0.sw();
double kHeightFormField = 50.0.sw();

// vertical space

Widget minVerticalSpace() {
  return Container(height: kMinSpace);
}

Widget smallVerticalSpace() {
  return Container(height: kSmallSpace);
}

Widget halfVerticalSpace() {
  return Container(height: kHalfSpace);
}

Widget normalVerticalSpace() {
  return Container(height: kNormalSpace);
}

Widget largeVerticalSpace() {
  return Container(height: kLargeSpace);
}

Widget veryLargeVerticalSpace() {
  return Container(height: kVeryLargeSpace);
}

Widget tooLargeVerticalSpace() {
  return Container(height: kTooLargeSpace);
}

// horizontal space

Widget minHorizontalSpace() {
  return Container(width: kMinSpace);
}

Widget smallHorizontalSpace() {
  return Container(width: kSmallSpace);
}

Widget halfHorizontalSpace() {
  return Container(width: kHalfSpace);
}

Widget normalHorizontalSpace() {
  return Container(width: kNormalSpace);
}

Widget largeHorizontalSpace() {
  return Container(width: kLargeSpace);
}

Widget veryLargeHorizontalSpace() {
  return Container(width: kVeryLargeSpace);
}

Widget tooLargeHorizontalSpace() {
  return Container(width: kTooLargeSpace);
}

Widget emptySpace() {
  return Container(width: 0.0, height: 0.0);
}