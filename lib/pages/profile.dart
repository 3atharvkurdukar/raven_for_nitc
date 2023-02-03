import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final user = FirebaseAuth.instance.currentUser;

  void signUserOut() {
    print('Signing out user...');
    GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                clipBehavior: Clip.hardEdge,
                child: Image.network(user!.photoURL!),
              ),
              SizedBox(height: 16),
              Text(
                user!.displayName ?? 'Anonymous',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              OutlinedButton.icon(
                  onPressed: signUserOut,
                  icon: Icon(Icons.logout),
                  label: Text('Log Out'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8))),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
