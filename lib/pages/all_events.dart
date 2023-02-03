import 'package:flutter/material.dart';
import 'package:raven_for_nitc/components/events.dart';

class AllEventsPage extends StatelessWidget {
  const AllEventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Events'),
        backgroundColor: Colors.black,
      ),
      body: Events(),
    );
  }
}
