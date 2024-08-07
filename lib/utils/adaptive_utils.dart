import 'package:flutter/material.dart';

mixin StyleMixin {
  double widthSF(BuildContext context) =>
      MediaQuery.of(context).size.width / 360;
  double heightSF(BuildContext context) =>
      MediaQuery.of(context).size.height / 640;
  double radiusSF(BuildContext context) =>
      MediaQuery.of(context).size.width / 375;
}
