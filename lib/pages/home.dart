import 'package:flutter/material.dart';
import 'package:raven_for_nitc/components/announcements.dart';
import 'package:raven_for_nitc/components/events.dart';
import 'package:raven_for_nitc/pages/all_announcements.dart';
import 'package:raven_for_nitc/pages/all_events.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Events', style: Theme.of(context).textTheme.headlineSmall),
              OutlinedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllEventsPage(),
                    ),
                  );
                },
                child: Text('View All'),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 320,
          child: Events(
            scrollDirection: Axis.horizontal,
            activeOnly: true,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Announcements',
                  style: Theme.of(context).textTheme.headlineSmall),
              OutlinedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllAnnouncementsPage(),
                    ),
                  );
                },
                child: Text('View All'),
              ),
            ],
          ),
        ),
        Announcements(activeOnly: true),
      ],
    );
  }
}
