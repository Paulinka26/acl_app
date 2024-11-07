import 'package:flutter/material.dart';
import '../../theme/theme_helper.dart';

class AppBarTitle extends StatelessWidget {
  AppBarTitle({Key? key, required this.text, this.onTap, this.margin})
      : super(key: key);

  final String text;
  final Function? onTap;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: GestureDetector(
        onTap: () {
          onTap?.call();
        },
        child: Text(
          text,
          style: theme.textTheme.titleLarge!.copyWith(
            color: appTheme.gray50,
          ),
        ),
      ),
    );
  }
}
