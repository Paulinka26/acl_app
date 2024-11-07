import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:acl_application/core/utils/size_utils.dart';
import '../../theme/custom_button_style.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_buttom_navigation.dart';
import '../../widgets/custom_elevated_button.dart';
import 'sleep_duration_section.dart';
import 'sleep_quality_section.dart';
import 'sleep_sufficiency_indicator.dart';

class SleepPage extends StatefulWidget {
  SleepPage({Key? key}) : super(key: key);

  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  int durationHours = 2;
  int durationMinutes = 0;
  String sleepQuality = 'Good';
  bool isDataSaved = false;

  @override
  void initState() {
    super.initState();
    loadSleepData(); // Load data on initialization
  }

  void loadSleepData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String todayDate = DateTime.now().toIso8601String().substring(0, 10);

    DocumentSnapshot doc = await firestore.collection('sleepData').doc(todayDate).get();

    if (doc.exists) {
      setState(() {
        durationHours = doc['durationHours'];
        durationMinutes = doc['durationMinutes'];
        sleepQuality = doc['sleepQuality'];
        isDataSaved = true; // Indicate that the data is saved
      });
    }
  }

  void saveSleepData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String todayDate = DateTime.now().toIso8601String().substring(0, 10);

    // Sprawdzenie, czy dane zostały już zapisane
    if (!isDataSaved) {
      try {
        await firestore.collection('sleepData').doc(todayDate).set({
          'durationHours': durationHours,
          'durationMinutes': durationMinutes,
          'sleepQuality': sleepQuality,
        });

        setState(() {
          isDataSaved = true; // Ustawienie flagi na true po zapisie
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Dane snu zostały zapisane!'),
        ));
      } catch (e) {
        print('Błąd podczas zapisywania danych snu: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Nie udało się zapisać danych snu. Spróbuj ponownie później.'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Dane zostały już zapisane dzisiaj.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Today's Sleep",
                            style: theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SleepDurationSection(
                      durationHours: durationHours,
                      durationMinutes: durationMinutes,
                      isDataSaved: isDataSaved,
                      onDurationChanged: (hours, minutes) {
                        setState(() {
                          durationHours = hours;
                          durationMinutes = minutes;
                        });
                      },
                    ),
                    SizedBox(height: 30.h),
                    SleepQualitySection(
                      sleepQuality: sleepQuality,
                      isDataSaved: isDataSaved,
                      onQualityChanged: (quality) {
                        setState(() {
                          sleepQuality = quality;
                        });
                      },
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: CustomElevatedButton(
                          height: 35.h,
                          width: 300.h,
                          text: "Save",
                          buttonStyle: CustomButtonStyles.fillPrimary,
                          buttonTextStyle: CustomTextStyles.titleSmallBold,
                          onPressed: isDataSaved ? null : saveSleepData,
                        ),
                    ),
                    SleepSufficiencyIndicator(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigation(
          selectedIndex: 0,
          onTap: (BottomBarEnum type) {},
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppBarTitle(
        text: "Sleep",
      ),
      styleType: Style.bgFill,
    );
  }
}
