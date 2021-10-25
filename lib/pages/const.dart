import 'package:flutter/material.dart';

const Color themeColor = Color.fromRGBO(220, 220, 220, 1.0);

// 屏幕宽
double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

// 屏幕高
double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}