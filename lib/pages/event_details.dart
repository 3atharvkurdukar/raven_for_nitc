import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventDetailsPage extends StatelessWidget {
  EventDetailsPage({super.key, required this.docId});

  final String docId;

  String getDateTimeString(dynamic t) =>
      DateFormat('dd MMM yy, hh:mm a').format((t as Timestamp).toDate());

  @override
  Widget build(BuildContext context) {
    CollectionReference events =
        FirebaseFirestore.instance.collection('events');

    return FutureBuilder<DocumentSnapshot>(
      future: events.doc(docId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            appBar: AppBar(
              title: Text(data['title']),
              backgroundColor: Colors.black,
            ),
            body: Padding(
              padding: EdgeInsets.all(16),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 16),
                  data['imageUrl'] != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(data['imageUrl']),
                        )
                      : Container(),
                  SizedBox(height: 16),
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Container(
                        alignment: Alignment.center,
                        child: data['endTime'] != null
                            ? Text(
                                '${getDateTimeString(data['startTime'])}\nto\n${getDateTimeString(data['endTime'])}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5,
                                ),
                              )
                            : Text(
                                '${getDateTimeString(data['startTime'])}\n onwards',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  data['description'] != null
                      ? Card(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              data['description'].replaceAll('\\n', '\n'),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          );
        }

        return Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
