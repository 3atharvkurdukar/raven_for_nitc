import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:raven_for_nitc/components/announcement_card.dart';

class Announcements extends StatefulWidget {
  Announcements({
    super.key,
    this.activeOnly = false,
  });

  final bool activeOnly;

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  late Stream<QuerySnapshot> _announcementsStream = FirebaseFirestore.instance
      .collection('announcements')
      .orderBy('createdAt', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _announcementsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error.toString());
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return AnnouncementCard.dummy();
              });
        }

        List<Map<String, dynamic>> data = snapshot.data!.docs
            .map((doc) => doc.data()! as Map<String, dynamic>)
            .toList();
        if (widget.activeOnly) {
          data = data
              .where((item) => item['endTime'].toDate().isAfter(DateTime.now()))
              .toList();
        }

        return ListView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: data.map((Map<String, dynamic> event) {
            return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(event['authority'])
                    .get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> userSnapshot) {
                  if (userSnapshot.hasError) {
                    return Text("Something went wrong");
                  }
                  if (userSnapshot.hasData && !userSnapshot.data!.exists) {
                    return Text("Document does not exist");
                  }

                  if (userSnapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> userData =
                        userSnapshot.data!.data() as Map<String, dynamic>;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: AnnouncementCard(
                        sender: userData['displayName'],
                        title: event['title'],
                      ),
                    );
                  }

                  return AnnouncementCard.dummy();
                });
          }).toList(),
        );
      },
    );
  }
}
