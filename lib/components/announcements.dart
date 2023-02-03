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
  late Stream<QuerySnapshot> _announcementsStream;

  @override
  void initState() {
    super.initState();
    _announcementsStream = widget.activeOnly
        ? FirebaseFirestore.instance
            .collection('announcements')
            .where('endTime', isGreaterThanOrEqualTo: DateTime.now())
            .snapshots()
        : FirebaseFirestore.instance.collection('announcements').snapshots();
  }

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
          return Text("Loading");
        }

        return ListView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection('users')
                    .doc(data['authority'])
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
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: AnnouncementCard(
                        sender: userData['displayName'],
                        title: data['title'],
                      ),
                    );
                  }

                  return Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                });
          }).toList(),
        );
      },
    );
  }
}
