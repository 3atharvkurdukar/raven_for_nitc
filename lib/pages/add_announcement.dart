import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddAnnouncementForm extends StatelessWidget {
  const AddAnnouncementForm({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Add Announcement';

    return Scaffold(
      appBar: AppBar(
        title: const Text(appTitle),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: const MyCustomForm(),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now();
  bool _loading = false;

  Future<void> submitHandler() async {
    if (_loading) return;
    _loading = true;
    if (_title.isEmpty || _title.length > 50) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Title must be less than 50 characters and non empty'),
          backgroundColor: Colors.white));
      _loading = false;
      return;
    }
    if (_endTime.isBefore(_startTime)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Start Date must be before End Date'),
          backgroundColor: Colors.white));
      _loading = false;
      return;
    } else if (_startTime.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Start Time must be after current time'),
          backgroundColor: Colors.white));
      _loading = false;
      return;
    }
    await FirebaseFirestore.instance.collection('announcements').add({
      'title': _title,
      'startTime': _startTime,
      'endTime': _endTime,
      'createdAt': DateTime.now(),
      'authority': FirebaseAuth.instance.currentUser!.uid
    });
    _loading = false;
    Navigator.of(context).pop();

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return ListView(
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Announcement',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    _title = value;
                  }),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'From',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500]),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Card(
                      child: SizedBox(
                        height: 100,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.dateAndTime,
                          initialDateTime: DateTime.now(),
                          // maximumYear: 2025,
                          // minimumYear: 2021,
                          onDateTimeChanged: (DateTime newDateTime) {
                            _startTime = newDateTime;
                          },
                          use24hFormat: false,

                          minuteInterval: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'To',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500]),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Card(
                      child: SizedBox(
                        height: 100,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.dateAndTime,
                          initialDateTime: DateTime.now(),
                          // maximumYear: 2025,
                          // minimumYear: 2021,
                          // dateOrder: CupertinoDatePickerDateOrder.mdy,
                          onDateTimeChanged: (DateTime newDateTime) {
                            _endTime = newDateTime;
                          },
                          use24hFormat: false,
                          minuteInterval: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                      ),
                      onPressed: !_loading ? submitHandler : null,
                      child: Text("Submit"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
