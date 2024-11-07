import 'package:flutter/material.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/theme_helper.dart';

enum Style { bgFill }

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    Key? key,
    this.height,
    this.styleType,
    this.leadingWidth,
    this.leading,
    this.title,
    this.centerTitle,
    this.actions,
  }) : super(key: key);

  final double? height;
  final Style? styleType;
  final double? leadingWidth;
  final Widget? leading;
  final Widget? title;
  final bool? centerTitle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height ?? 112.h,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
    SizeUtils.width,
    height ?? 112.h,
  );
   _getStyle() {
    switch (styleType) {
      case Style.bgFill:
        return Container(
          height: 112.h,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: appTheme.blueGray700,
            borderRadius: BorderRadius.circular(16.h),
          ),
        );
      default:
        return null;
    }
  }
}
