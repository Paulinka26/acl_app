import 'package:acl_application/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/image_constant.dart';
import '../../../theme/app_decoration.dart';
import '../../../theme/theme_helper.dart';
import '../../../widgets/custom_image_view.dart';
import '../../../widgets/custom_icon_button.dart';

class GlobeSectionItemWidget extends StatelessWidget {
  final String title;
  final String iconPath;

  const GlobeSectionItemWidget({
    Key? key,
    required this.title,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.h,
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
        color: appTheme.blueGray50,
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomIconButton(
            height: 30.h,
            width: 30.h,
            padding: EdgeInsets.all(8.h),
            child: CustomImageView(
              imagePath: iconPath,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall,
          ),
          SizedBox(height: 18.h),
        ],
      ),
    );
  }
}

class GlobeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GlobeSectionItemWidget(
          title: "Football",
          iconPath: ImageConstant.imgBallIcon,
        ),
        GlobeSectionItemWidget(
          title: "Workouts",
          iconPath: ImageConstant.imgWorkoutIcon,
        ),
        GlobeSectionItemWidget(
          title: "Sleep",
          iconPath: ImageConstant.imgSleepIcon,
        ),
      ],
    );
  }
}
