import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raven_for_nitc/pages/home.dart';
import 'package:raven_for_nitc/pages/amenities.dart';
import 'package:raven_for_nitc/pages/mess.dart';
import 'package:raven_for_nitc/pages/profile.dart';

class MyNavigator extends StatelessWidget {
  const MyNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PageControllerModel>(context);
    return Scaffold(
      body: PageView(
        controller: model.pageController,
        children: [
          HomePage(),
          MessPage(),
          AmenitiesPage(),
          ProfilePage(),
        ],
        onPageChanged: (index) {
          model.selectedIndex = index;
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Mess',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_tennis),
            label: 'Amenities',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: model.selectedIndex,
        onTap: (index) {
          model.pageController.jumpToPage(index);
        },
      ),
    );
  }
}

class PageControllerModel with ChangeNotifier {
  int _selectedIndex = 0;
  PageController _pageController = PageController();

  int get selectedIndex => _selectedIndex;
  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  PageController get pageController => _pageController;
}
