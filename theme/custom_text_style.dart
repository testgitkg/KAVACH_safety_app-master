import 'package:flutter/material.dart';
import 'package:kavach_project/core/utils/size_utils.dart';
import 'package:kavach_project/theme/theme_helper.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodyLargeBlack900 => theme.textTheme.bodyLarge!.copyWith(
        color: appTheme.black900,
        fontSize: 16.fSize,
      );
  static get bodyLargePrimaryContainer => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 17.fSize,
      );
  static get bodyLargePrimaryContainer18 => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 18.fSize,
      );
  static get bodyLargePrimaryContainer_1 => theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.primaryContainer,
      );
  static get bodyMedium14 => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 14.fSize,
      );
  static get bodyMedium14_1 => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 14.fSize,
      );
  static get bodyMedium15 => theme.textTheme.bodyMedium!.copyWith(
        fontSize: 15.fSize,
      );
  static get bodyMediumBlack900 => theme.textTheme.bodyMedium!.copyWith(
        color: appTheme.black900,
        fontSize: 15.fSize,
      );
  static get bodyMediumCabinBlack900 =>
      theme.textTheme.bodyMedium!.cabin.copyWith(
        color: appTheme.black900,
        fontSize: 15.fSize,
      );
  static get bodyMediumKalamOnPrimary =>
      theme.textTheme.bodyMedium!.kalam.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        fontSize: 15.fSize,
      );
  static get bodySmall12 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 12.fSize,
      );
  static get bodySmall9 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 9.fSize,
      );
  static get bodySmall9_1 => theme.textTheme.bodySmall!.copyWith(
        fontSize: 9.fSize,
      );
  static get bodySmallBlack900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
        fontSize: 8.fSize,
      );
  static get bodySmallBlack90010 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
        fontSize: 10.fSize,
      );
  static get bodySmallBlack90012 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
        fontSize: 12.fSize,
      );
  static get bodySmallBlack90012_1 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900,
        fontSize: 12.fSize,
      );
  static get bodySmallGray50001 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray50001,
        fontSize: 8.fSize,
      );
  static get bodySmallGray50002 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray50002,
      );
  static get bodySmallGray50003 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray50003,
        fontSize: 10.fSize,
      );
  static get bodySmallGray5000310 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray50003,
        fontSize: 10.fSize,
      );
  static get bodySmallGray5000312 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray50003,
        fontSize: 12.fSize,
      );
  static get bodySmallGray500039 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray50003,
        fontSize: 9.fSize,
      );
  static get bodySmallGray500039_1 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray50003,
        fontSize: 9.fSize,
      );
  static get bodySmallGray50003_1 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray50003,
      );
  static get bodySmallGray600 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray600,
        fontSize: 8.fSize,
      );
  static get bodySmallGray700 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray700,
        fontSize: 9.fSize,
      );
  static get bodySmallGray70001 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray70001,
        fontSize: 10.fSize,
      );
  static get bodySmallGray70002 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.gray70002,
        fontSize: 10.fSize,
      );
  static get bodySmallOnPrimaryContainer => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimaryContainer.withOpacity(1),
        fontSize: 9.fSize,
      );
  // Label text style
  static get labelLargeGray5009b => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.gray5009b,
        fontSize: 13.fSize,
      );
  static get labelLargePrimaryContainer => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontSize: 13.fSize,
      );
  // Title text style
  static get titleMediumPurpleA100 => theme.textTheme.titleMedium!.copyWith(
        color: appTheme.purpleA100,
      );
}

extension on TextStyle {
  TextStyle get cabin {
    return copyWith(
      fontFamily: 'Cabin',
    );
  }

  TextStyle get arial {
    return copyWith(
      fontFamily: 'Arial',
    );
  }

  TextStyle get kalam {
    return copyWith(
      fontFamily: 'Kalam',
    );
  }
}
