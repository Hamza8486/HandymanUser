// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class AppPaddings {
  static const EdgeInsets defaultPadding = EdgeInsets.all(16);
  static const EdgeInsets topOnly = EdgeInsets.only(top: 16);
  static const EdgeInsets bottomOnly = EdgeInsets.only(bottom: 16);
  static const EdgeInsets leftOnly = EdgeInsets.only(left: 16);
  static const EdgeInsets rightOnly = EdgeInsets.only(right: 16);
  static const EdgeInsets vertical = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets horizontal = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets horizontal1 = EdgeInsets.symmetric(horizontal: 24);
  static const EdgeInsets symetric = EdgeInsets.symmetric(horizontal: 25,vertical: 16);
  static const EdgeInsets both = EdgeInsets.symmetric(horizontal: 15,vertical: 18);
}
