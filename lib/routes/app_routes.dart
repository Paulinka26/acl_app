import 'package:flutter/material.dart';
import '../presentation/home_page/home_page.dart';
import '../presentation/login_page/login_page.dart';
import '../presentation/profile_page/profile_page.dart';
import '../presentation/sleep_page/sleep_page.dart';
import '../presentation/trainingCalendar_page/trainingCalendar_page.dart';
import '../presentation/trainingCalendar_page/trainings_page.dart';
import '../presentation/trainingCalendar_page/treningsListPage.dart';
import '../presentation/workout_page/choose_plan_page.dart';



class AppRoutes {
  static const String loginPage = '/loginpage_screen';
  static const String columnforgotpasTabPage = '/columnforgotpas_tab_page';
  static const String registerpagePage = '/register_page';
  static const String homePage = '/home_page';
  static const String sleepPage = '/sleep_page';
  static const String trainingcalendarPage = '/trainingCalendar_page';
  static const String trainingsListPage = '/trainingsList_page';
  static const String trainingsPage = '/trainings_page';
  static const String choosePlanPage = '/chooseTrainingSet_page';
  static const String trainingSetPage = '/trainingSet_page';
  static const String profilepagePage = '/profile_page';
  static const String initialRoute = '/initialRoute';

  static Map<String, WidgetBuilder> routes = {
    loginPage: (context) => const LoginPage(),
    homePage: (context) => HomePage(),
    sleepPage: (context) => SleepPage(),
    trainingcalendarPage: (context) => TrainingCalendarPage(),
    trainingsListPage: (context) => TrainingsListPage(),
    trainingsPage: (context) => TrainingsPage(),
    choosePlanPage: (context) => const ChoosePlanPage(),
    profilepagePage: (context) => const ProfilePage(),
    initialRoute: (context) => const LoginPage(),
  };
}
