
import 'package:kavach_project/core/utils/size_utils.dart';

import '../../../core/utils/image_constant.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/custom_image_view.dart';
import '../models/chipview_item_model.dart';
import 'package:flutter/material.dart' hide DrawerController;

// ignore: must_be_immutable
class ChipviewItemWidget extends StatelessWidget {
  ChipviewItemWidget(
    this.chipviewItemModelObj, {
    Key? key,
    this.onSelectedChipView1,
  }) : super(
          key: key,
        );

  ChipviewItemModel chipviewItemModelObj;

  Function(bool)? onSelectedChipView1;

  @override
  Widget build(BuildContext context) {
    return RawChip(
      padding: EdgeInsets.only(
        top: 30.v,
        right: 30.h,
        bottom: 30.v,
      ),
      showCheckmark: false,
      labelPadding: EdgeInsets.zero,
      label: Text(
        chipviewItemModelObj.history!,
        style: TextStyle(
          color: theme.colorScheme.primaryContainer,
          fontSize: 11.fSize,
          fontFamily: 'Arial',
          fontWeight: FontWeight.w400,
        ),
      ),
      avatar: CustomImageView(
        imagePath: ImageConstant.imgText28786711,
        height: 21.adaptSize,
        width: 21.adaptSize,
        margin: EdgeInsets.only(right: 20.h),
      ),
      selected: (chipviewItemModelObj.isSelected ?? false),
      backgroundColor: appTheme.gray10001,
      selectedColor: appTheme.gray10001,
      shape: (chipviewItemModelObj.isSelected ?? false)
          ? RoundedRectangleBorder(
              side: BorderSide(
                color: appTheme.gray10001.withOpacity(0.6),
                width: 1.h,
              ),
              borderRadius: BorderRadius.circular(
                16.h,
              ),
            )
          : RoundedRectangleBorder(
              side: BorderSide(
                color: appTheme.purple10001,
                width: 1.h,
              ),
              borderRadius: BorderRadius.circular(
                16.h,
              ),
            ),
      onSelected: (value) {
        onSelectedChipView1?.call(value);
      },
    );
  }
}
