import 'package:flutter/material.dart';
import 'package:acl_application/core/utils/size_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_decoration.dart';
import '../../theme/custom_button_style.dart';
import '../../theme/custom_text_style.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_buttom_navigation.dart';
import '../../widgets/custom_elevated_button.dart';
import 'custom_data_field.dart';
import 'injury_dropdown.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isSelectedSwitch = false;
  bool isSelectedSwitch1 = false;
  int selectedIndex = 4;

  int age = 0;
  int weight = 0;
  int height = 0;
  String selectedInjury = 'No injury';

  @override
  void initState() {
    super.initState();
    _loadUserParameters(); // Załaduj dane użytkownika przy inicjalizacji
  }

  void _loadUserParameters() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not logged in.");
      return;
    }

    final parametersRef = FirebaseFirestore.instance.collection('usersParam').doc(user.uid);
    final docSnapshot = await parametersRef.get();

    if (docSnapshot.exists) {
      // Zaktualizuj lokalne zmienne na podstawie danych z Firestore
      setState(() {
        age = docSnapshot['age'] ?? 0;
        weight = docSnapshot['weight'] ?? 0;
        height = docSnapshot['height'] ?? 0;
        selectedInjury = docSnapshot['selectedInjury'] ?? 'No injury';
      });
    }
  }

  void saveUserParameters() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("User is not logged in."); // Dodaj logowanie w przypadku braku zalogowanego użytkownika
      return;
    }

    final parametersRef = FirebaseFirestore.instance.collection('usersParam').doc(user.uid);

    // Sprawdź, czy dokument istnieje
    final docSnapshot = await parametersRef.get();

    if (!docSnapshot.exists) {
      // Utwórz nowy dokument, jeśli nie istnieje
      await parametersRef.set({
        'age': age,
        'weight': weight,
        'height': height,
        'selectedInjury': selectedInjury,
      });
    } else {
      // Zaktualizuj istniejący dokument
      await parametersRef.update({
        'age': age,
        'weight': weight,
        'height': height,
        'selectedInjury': selectedInjury,
      });
    }
  }

  @override
  void dispose() {
    saveUserParameters(); // Zapisanie danych do Firestore
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 400.h,
                  height: 400.h,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildAppBar(context),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        Text(
                          "Account",
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: 18.h),
                        _buildAccountColumn(context),
                        SizedBox(height: 20.h),
                        Text(
                          "Notifications",
                          style: theme.textTheme.titleMedium,
                        ),
                        SizedBox(height: 18.h),
                        _buildNotificationsColumn(context),
                        Center(
                          child: CustomElevatedButton(
                            height: 40.h,
                            width: 300.h,
                            text: "Logout",
                            buttonStyle: CustomButtonStyles.fillPrimary,
                            buttonTextStyle: CustomTextStyles.titleSmallBold,
                            onPressed: () => _onTapLogout(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigation(
          selectedIndex: selectedIndex,
          onTap: (type) {
            setState(() {
              selectedIndex = BottomBarEnum.values.indexOf(type);
            });
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: AppBarTitle(
        text: "Profile",
      ),
      styleType: Style.bgFill,
    );
  }

  Widget _buildAccountColumn(BuildContext context) {
    return Column(
      children: [
        CustomDataField(
          label: "Age",
          value: age.toString(),
          onIncrement: () => setState(() => age++),
          onDecrement: () => setState(() => age--),
        ),
        CustomDataField(
          label: "Weight",
          value: "$weight kg",
          onIncrement: () => setState(() => weight++),
          onDecrement: () => setState(() => weight--),
        ),
        CustomDataField(
          label: "Height",
          value: "$height cm",
          onIncrement: () => setState(() => height++),
          onDecrement: () => setState(() => height--),
        ),
        InjuryDropdown(
          selectedInjury: selectedInjury,
          onChanged: (String? newValue) {
            setState(() {
              selectedInjury = newValue!;
            });
          },
        ),
      ],
    );
  }

  Widget _buildNotificationRow(BuildContext context, String label, bool value, Function(bool) onChange) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.h),
          child: Text(
            label,
            style: CustomTextStyles.labelLargeMedium,
          ),
        ),
        Switch(
          value: value,
          onChanged: onChange,
        ),
      ],
    );
  }

  Widget _buildNotificationsColumn(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 14.h, vertical: 10.h),
      decoration: BoxDecoration(
        color: appTheme.blueGray50,
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNotificationRow(context, "SMS notifications", isSelectedSwitch, (value) {
            setState(() {
              isSelectedSwitch = value;
            });
          }),
          Divider(),
          _buildNotificationRow(context, "Email notifications", isSelectedSwitch1, (value) {
            setState(() {
              isSelectedSwitch1 = value;
            });
          }),
        ],
      ),
    );
  }

  void _onTapLogout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, AppRoutes.loginPage);
  }
}
