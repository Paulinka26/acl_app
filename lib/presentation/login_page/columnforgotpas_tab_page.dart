import 'package:acl_application/core/utils/size_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../routes/app_routes.dart';
import '../../theme/custom_button_style.dart';
import '../../theme/custom_text_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_from_field.dart';
import '../profile_page/profile_page.dart';

class ColumnForgotPasTabPage extends StatefulWidget {
  const ColumnForgotPasTabPage({Key? key}) : super(key: key);

  @override
  ColumnForgotPasTabPageState createState() => ColumnForgotPasTabPageState();
}

class ColumnForgotPasTabPageState extends State<ColumnForgotPasTabPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void signUserIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Sign in the user
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      Navigator.pop(context); // Close the loading dialog
      Navigator.pushNamed(context, AppRoutes.profilepagePage); // Navigate to profile page
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close the loading dialog
      _showErrorSnackBar(e.message ?? 'An error occurred');
    } catch (e) {
      Navigator.pop(context); // Close the loading dialog
      _showErrorSnackBar('An unexpected error occurred.');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.h, vertical: 72.h),
      child: Column(
        children: [_buildLoginForm(context)],
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomTextFormField(
            controller: emailController,
            hintText: "Email",
            textInputType: TextInputType.emailAddress,
            contentPadding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 12.h),
          ),
          SizedBox(height: 14.h),
        CustomTextFormField(
          controller: passwordController,
          hintText: "Password",
          textInputType: TextInputType.visiblePassword,
          obscureText: true,
          textInputAction: TextInputAction.done,
          contentPadding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 12.h),
        ),
          SizedBox(height: 14.h),
          GestureDetector(
            onTap: () {
              // funkcja forgot password
            },
            child: Text(
              "Forgot Password?",
              style: CustomTextStyles.labelLargePrimary,
            ),
          ),
          SizedBox(height: 40.h),
          CustomElevatedButton(
            height: 44.h,
            text: "Login",
            buttonStyle: CustomButtonStyles.fillPrimary,
            buttonTextStyle: CustomTextStyles.titleSmallBold,
            onPressed: signUserIn,
          ),
        ],
      ),
    );
  }


  void _onTapLogin(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.homePage);
  }
}
