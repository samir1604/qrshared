import 'package:flutter/material.dart';

extension BuildcontextExtension on BuildContext {
  static const _smallScreenThreshold = 320.0;

  Size get getSize => MediaQuery.sizeOf(this);

  double get systemTopPadding => MediaQuery.viewPaddingOf(this).top;

  double get systemBottomPadding => MediaQuery.viewPaddingOf(this).bottom;

  double get safeBottomSpacing =>
      systemBottomPadding > 0 ? systemTopPadding : spacingMedium;

  double get textScaleFactor => MediaQuery.textScalerOf(this).scale(1);

  double get effectiveWidth =>
      getSize.width / MediaQuery.textScalerOf(this).scale(1);

  bool get isSmallWidth => effectiveWidth < _smallScreenThreshold;

  // Adaptive Units
  double get spacingSmall => isSmallWidth ? 4.0 : 8.0;

  double get spacingMedium => isSmallWidth ? 8.0 : 16.0;

  double get spacingLarge => isSmallWidth ? 16.0 : 32.0;

  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(this);

  // Visual Center considering system elementes
  Offset getCenterOfBody(double appBarHeight) {
    final availableHeight =
        getSize.height - appBarHeight - systemTopPadding - systemBottomPadding;
    return Offset(getSize.width / 2, availableHeight / 2);
  }
}
