import 'package:flutter/material.dart';
import 'package:kavach_project/core/utils/size_utils.dart';
import 'package:kavach_project/localization/app_localization.dart';

import '../core/utils/image_constant.dart';
import '../theme/custom_text_style.dart';
import '../theme/theme_helper.dart';
import 'custom_image_view.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgNavTrackMe,
      activeIcon: ImageConstant.imgNavTrackMe,
      title: "lbl_track_me".tr,
      type: BottomBarEnum.Trackme,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgTape74759501,
      activeIcon: ImageConstant.imgTape74759501,
      title: "lbl_record".tr,
      type: BottomBarEnum.Record,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgSos46171041,
      activeIcon: ImageConstant.imgSos46171041,
      title: "lbl_track_me".tr,
      type: BottomBarEnum.Trackme,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgPhoneSet9658965,
      activeIcon: ImageConstant.imgPhoneSet9658965,
      title: "lbl_fake_call".tr,
      type: BottomBarEnum.Fakecall,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgNavHelpline,
      activeIcon: ImageConstant.imgNavHelpline,
      title: "lbl_helpline".tr,
      type: BottomBarEnum.Helpline,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.v,
      decoration: BoxDecoration(
        color: theme.colorScheme.onError,
        borderRadius: BorderRadius.circular(
          20.h,
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: SizedBox(
              height: 34.v,
              width: 27.h,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CustomImageView(
                    imagePath: bottomMenuList[index].icon,
                    height: 27.adaptSize,
                    width: 27.adaptSize,
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.only(bottom: 7.v),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 24.v,
                        right: 1.h,
                      ),
                      child: Text(
                        bottomMenuList[index].title ?? "",
                        style: CustomTextStyles.bodySmallBlack900.copyWith(
                          color: appTheme.black900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: bottomMenuList[index].activeIcon,
                  height: 21.adaptSize,
                  width: 21.adaptSize,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 1.v),
                  child: Text(
                    bottomMenuList[index].title ?? "",
                    style: CustomTextStyles.bodySmallBlack900.copyWith(
                      color: appTheme.black900,
                    ),
                  ),
                ),
              ],
            ),
            label: '',
          );
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

enum BottomBarEnum {
  Trackme,
  Record,
  Fakecall,
  Helpline,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
  });

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
