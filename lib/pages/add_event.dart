import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddEventPage extends StatelessWidget {
  const AddEventPage({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Add Event';

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
  File? _image;
  String title = '';
  String description = '';
  DateTime? startTime;
  DateTime? endTime;
  String downloadUrl = '';

  TextEditingController dateController = TextEditingController();
  TextEditingController timeCtl = TextEditingController();
  DateTime date = DateTime.now();
  bool loading = false;

  Future getImage() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image != null ? image.path : image!.path);
    });
  }

  Future<void> eventHandler() async {
    if (loading) return;
    loading = true;
    if (title.isEmpty || title.length > 50) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Title must be less than 50 characters and non empty'),
          backgroundColor: Colors.white54));
      loading = false;
      return;
    } else if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Description cannot be empty'),
          backgroundColor: Colors.white54));
      loading = false;
      return;
    } else if (startTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select a date and time'),
          backgroundColor: Colors.white54));
      loading = false;
      return;
    } else if (endTime != null && endTime!.isBefore(startTime!)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Start Date must be before End Date'),
          backgroundColor: Colors.white54));
      loading = false;
      return;
    } else if (startTime!.isBefore(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Start Time must be after current time'),
          backgroundColor: Colors.white54));
      loading = false;
      return;
    }

    if (_image != null) {
      FirebaseStorage storage = FirebaseStorage.instance;
      String path = _image!.path.split('/').last;
      Reference ref = storage.ref().child('events/$path');
      UploadTask uploadTask = ref.putFile(_image!);
      await uploadTask.whenComplete(() => print('File Uploaded'));
      downloadUrl = await ref.getDownloadURL();
    }

    print('this is the download url $downloadUrl');
    await FirebaseFirestore.instance.collection('events').add({
      'title': title,
      'description': description,
      'startTime': startTime,
      'endTime': endTime,
      'createdAt': DateTime.now(),
      'imageUrl': downloadUrl != '' ? downloadUrl : null,
      'authority': FirebaseAuth.instance.currentUser!.uid,
    });
    // should disable the submit button and show a loadder
    loading = false;
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return ListView(
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Event Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    title = value;
                  }),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    if (value.length > 30) {
                      return 'Name should be less than 30 characters';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: TextFormField(
                  maxLines: 8,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Event Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onChanged: (value) => setState(() {
                    description = value;
                  }),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    labelText: 'Event Venue',
                    hintText: '(Optional)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Event Start Date',
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
                          onDateTimeChanged: (DateTime newDateTime) {
                            startTime = newDateTime;
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
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Event Start Date',
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
                          onDateTimeChanged: (DateTime newDateTime) {
                            endTime = newDateTime;
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
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Event Image',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500]),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        getImage();
                      },
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        padding: MaterialStatePropertyAll(EdgeInsets.all(16)),
                      ),
                      child: Text('Select Image'),
                    ),
                  ],
                ),
              ),
              _image != null
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.file(
                          _image!,
                        ),
                      ),
                    )
                  : Container(),
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    MaterialButton(
                      color: Colors.white,
                      textColor: Colors.black,
                      onPressed: !loading ? eventHandler : null,
                      child: Text('Submit'),
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
