import 'package:flutter/material.dart';

extension BuildcontextExtension on BuildContext {
  Size get getSize => MediaQuery.sizeOf(this);

  double get systemTopPadding => MediaQuery.viewPaddingOf(this).top;

  double get systemBottomPadding => MediaQuery.viewPaddingOf(this).bottom;

  Offset getCenterOfBody(double appBarHeight) {
    final availableHeight =
        getSize.height - appBarHeight - systemTopPadding - systemBottomPadding;
    return Offset(getSize.width / 2, availableHeight / 2);
  }
}
