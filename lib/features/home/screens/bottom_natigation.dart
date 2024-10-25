import 'package:fashion_ai/features/explore/screens/explore_screen.dart';
import 'package:fashion_ai/features/home/screens/main_home.dart';
import 'package:fashion_ai/features/profile/screens/profile_screen.dart';
import 'package:fashion_ai/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyBottomNavigation extends StatefulWidget {
  final int? selectedIndex;
  const MyBottomNavigation({super.key, this.selectedIndex});

  @override
  State<MyBottomNavigation> createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {
  final List<Widget> _widgetOptions = <Widget>[
    const ExploreScreen(),
    const MainHome(),
    const ProfileScreen(),
  ];

  int _selectedIndex = 0;

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex ?? 0;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.getData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(color: Colors.white),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.white),
            label: 'Search',
            tooltip: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.white),
            label: 'Profile',
            tooltip: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
