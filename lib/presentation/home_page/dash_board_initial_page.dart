import 'package:acl_application/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import '../../core/utils/image_constant.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import 'widgets/dailygoalsection_item_widget.dart';
import 'widgets/globesection_item_widget.dart';

class DashBoardInitialPage extends StatefulWidget {
  const DashBoardInitialPage({Key? key}) : super(key: key);

  @override
  DashBoardInitialPageState createState() => DashBoardInitialPageState();
}

class DashBoardInitialPageState extends State<DashBoardInitialPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            SizedBox(height: 16.h),
            _buildGlobeSection(context),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.only(left: 8.h),
              child: Text(
                "Daily Goal",
                style: theme.textTheme.titleMedium,
              ),
            ),
            SizedBox(height: 16.h),
            _buildDailyGoalSection(context),
            SizedBox(height: 44.h),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppBarTitle(
        text: "Summary",
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildGlobeSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 12.h,
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
        ),
      ),
    );
  }

  Widget _buildDailyGoalSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.h, right: 12.h),
      child: ListView.separated(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(height: 14.h);
        },
        itemCount: 1,
        itemBuilder: (context, index) {
          return DailyGoalSectionItemWidget();
        },
      ),
    );
  }
}
