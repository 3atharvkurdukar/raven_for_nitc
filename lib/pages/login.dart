import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:raven_for_nitc/services/auth_service.dart';

class LoginPage extends StatelessWidget {
  signInWithGoogle(BuildContext context) async {
    try {
      await AuthService().signInWithGoogle();
    } catch (e) {
      GoogleSignIn().signOut();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(e.toString()),
              actions: [
                TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 200,
              margin: EdgeInsets.all(16),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16)),
              clipBehavior: Clip.hardEdge,
              child: Image.asset('assets/logo.png', width: 64),
            ),
            Text('Raven for NITC',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 64),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 64),
              child: ElevatedButton.icon(
                onPressed: () => signInWithGoogle(context),
                icon: Image.asset('assets/images/google_logo.png', width: 20),
                label: Text('Continue with Google'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
