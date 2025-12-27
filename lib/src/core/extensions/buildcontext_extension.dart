import 'package:flutter/material.dart';

extension BuildcontextExtension on BuildContext {
  Size get getSize => MediaQuery.sizeOf(this);

  double get getStatusBarHeight => MediaQuery.paddingOf(this).top;

  Offset getCenterOfBody(double appBarHeight) {
    final availableHeight = getSize.height - appBarHeight - getStatusBarHeight;
    return Offset(getSize.width / 2, availableHeight / 2);
  }
}
