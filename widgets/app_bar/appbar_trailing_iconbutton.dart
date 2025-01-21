import 'package:flutter/material.dart';
import 'package:kavach_project/core/utils/size_utils.dart';

import '../../core/utils/image_constant.dart';
import '../custom_icon_button.dart';
import '../custom_image_view.dart';

// ignore: must_be_immutable
class AppbarTrailingIconbutton extends StatelessWidget {
  AppbarTrailingIconbutton({
    Key? key,
    this.imagePath,
    this.margin,
    this.onTap,
  }) : super(
          key: key,
        );

  String? imagePath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!.call();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomIconButton(
          height: 25.v,
          width: 26.h,
          child: CustomImageView(
            imagePath: ImageConstant.imgClose80359091,
          ),
        ),
      ),
    );
  }
}
