import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:raven_for_nitc/pages/add_event.dart';
import 'package:raven_for_nitc/pages/home.dart';
import 'package:raven_for_nitc/pages/amenities.dart';
import 'package:raven_for_nitc/pages/mess.dart';
import 'package:raven_for_nitc/pages/profile.dart';

class MyNavigator extends StatelessWidget {
  MyNavigator({super.key});

  SpeedDial _homeFab(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.add_event,
      animatedIconTheme: IconThemeData(size: 22.0),
      backgroundColor: Colors.white,
      visible: true,
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.calendar_today),
          backgroundColor: Colors.black,
          label: 'New Event',
          labelStyle: TextStyle(fontSize: 18.0),
          labelBackgroundColor: Colors.transparent,
          onTap: () => {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddEventPage()),
            )
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.campaign_outlined),
          backgroundColor: Colors.black,
          label: 'New Announcement',
          labelStyle: TextStyle(fontSize: 18.0),
          labelBackgroundColor: Colors.transparent,
          onTap: () => {},
        )
      ],
    );
  }

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
      floatingActionButton:
          model._selectedIndex == 0 ? _homeFab(context) : null,
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
