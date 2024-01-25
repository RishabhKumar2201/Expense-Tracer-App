import 'package:flutter/material.dart';
import 'package:tracker_application/screens/home_screen.dart';
import 'package:tracker_application/screens/transaction_screen.dart';
import 'package:tracker_application/widgets/navbar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var isLogoutLoading = false;
  int currentIndex = 0;
  var pageViewList = [
    HomeScreen(),
    TransactionScreen(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (int value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),

      body: pageViewList[currentIndex],
    );
  }
}
