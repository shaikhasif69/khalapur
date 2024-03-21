import 'package:flutter/material.dart';
import 'package:health_care_app/utils/app_constants.dart';
import '../pages/doctor_display_screen.dart';
import '../pages/home_screen.dart';

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({Key? key}) : super(key: key);

  @override
  _UserDashBoardState createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  int _currentIndex = 0;
  final tabs = [
    HomeScreen(),
    DoctorDisplayScreen(),
    HomeScreen(),
    HomeScreen(),
    // Add other pages here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        height: 80,
        width: 80,
        child: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.keyboard_voice_rounded),
          backgroundColor: AppConstants.primaryColor,
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35.0),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[300],
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Container(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                icon: Icon(Icons.home),
                color: _currentIndex == 0 ? AppConstants.primaryColor : Colors.grey,
                // label: Text('Home'),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                icon: Icon(Icons.health_and_safety_outlined),
                color: _currentIndex == 1 ? AppConstants.primaryColor : Colors.grey,
                // label: Text('Search'),
              ),
              SizedBox(width: 40.0), // Adjust spacing for center FAB
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
                icon: Icon(Icons.account_circle_rounded),
                color: _currentIndex == 2 ? AppConstants.primaryColor : Colors.grey,
                // label: Text('Profile'),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
                icon: Icon(Icons.more_horiz),
                color: _currentIndex == 3 ? AppConstants.primaryColor : Colors.grey,
                // label: Text('More'),
              ),
            ],
          ),
        ),
      ),
      body: tabs[_currentIndex],
    );
  }
}
