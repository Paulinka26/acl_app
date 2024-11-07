import 'package:flutter/material.dart';
import '../../widgets/custom_buttom_navigation.dart';
import 'dash_board_initial_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:DashBoardInitialPage(),
      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: 2,
        onTap: (BottomBarEnum type) {
        },
      ),
    ),
    );
  }
}
