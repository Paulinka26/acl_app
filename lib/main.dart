import 'package:acl_application/routes/app_routes.dart';
import 'package:acl_application/theme/theme_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/utils/size_utils.dart';
import 'firebase_options.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          scaffoldMessengerKey: globalMessengerKey,
          theme: theme,
          title: 'paulina_s_applications',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.loginPage,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}
