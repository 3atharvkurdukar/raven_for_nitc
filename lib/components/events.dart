import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:raven_for_nitc/components/event_card.dart';

class Events extends StatefulWidget {
  Events({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.activeOnly = false,
  });

  final Axis scrollDirection;
  final bool activeOnly;

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  late Stream<QuerySnapshot> _eventsStream;

  @override
  void initState() {
    super.initState();
    _eventsStream = widget.activeOnly
        ? FirebaseFirestore.instance
            .collection('events')
            .where('startTime', isGreaterThanOrEqualTo: DateTime.now())
            .snapshots()
        : FirebaseFirestore.instance.collection('events').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _eventsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          scrollDirection: widget.scrollDirection,
          physics: BouncingScrollPhysics(),
          shrinkWrap: widget.scrollDirection == Axis.horizontal ? false : true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: EventCard(
                id: document.id,
                title: data['title'],
                imageUrl: data['imageUrl'],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
