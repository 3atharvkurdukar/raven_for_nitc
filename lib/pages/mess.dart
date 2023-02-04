import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:raven_for_nitc/components/mess_card.dart';

class MessPage extends StatefulWidget {
  const MessPage({super.key});

  @override
  State<MessPage> createState() => _MessState();
}

class _MessState extends State<MessPage> {
  int count = 0;

  bool _vegOnly = true;

  String getWeekday() {
    Map<int, String> weekdays = {
      1: "mon",
      2: "tue",
      3: "wed",
      4: "thu",
      5: "fri",
      6: "sat",
      7: "sun"
    };
    return weekdays[DateTime.now().subtract(Duration(days: count)).weekday]!;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('messTimetables').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            Text('Something went wrong');
          }
          if (snapshot.hasData && snapshot.data!.size == 0) {
            return Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.docs
                .map((doc) => doc.data() as Map<String, dynamic>)
                .toList();
            return ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  count += 1;
                                });
                              },
                              child: Icon(
                                Icons.chevron_left,
                                color: Colors.grey[300],
                                size: 32,
                              )),
                          Text(
                            DateFormat('E, MMM d').format(
                              DateTime.now().subtract(Duration(days: count)),
                            ),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                count -= 1;
                              });
                            },
                            child: Icon(
                              Icons.chevron_right,
                              color: Colors.grey[300],
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    alignment: Alignment.topRight,
                    child: ToggleButtons(
                      borderRadius: BorderRadius.circular(8),
                      isSelected: [!_vegOnly, _vegOnly],
                      onPressed: (int index) {
                        setState(() {
                          _vegOnly = index == 1;
                        });
                      },
                      children: <Widget>[
                        Text('All'),
                        Text('Veg Only'),
                      ],
                    ),
                  ),
                ),
                ...data.where((d) => !_vegOnly || d['vegOnly']).map(
                      (d) => MessCard(
                        name: d['name'],
                        breakfast: d[getWeekday()]["breakfast"],
                        lunch: d[getWeekday()]["lunch"],
                        snacks: d[getWeekday()]["snacks"],
                        dinner: d[getWeekday()]["dinner"],
                      ),
                    ),
              ],
            );
          }
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        });
  }
}
