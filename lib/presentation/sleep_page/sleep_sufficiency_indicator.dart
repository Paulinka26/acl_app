import 'package:flutter/material.dart';
import '../../theme/theme_helper.dart';
import 'package:acl_application/core/utils/size_utils.dart';

class SleepSufficiencyIndicator extends StatelessWidget {
  final int sufficientSleepDays = 5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sufficient Sleep in the Last Week",
            style: theme.textTheme.titleMedium,
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.maxFinite,
            height: 100.h,
            decoration: BoxDecoration(
              color: appTheme.blueGray50,
              borderRadius: BorderRadius.circular(16.h),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LinearProgressIndicator(
                    value: sufficientSleepDays / 7,
                    backgroundColor: Colors.grey,
                    color: Colors.green,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "$sufficientSleepDays out of 7 days were sufficient",
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
