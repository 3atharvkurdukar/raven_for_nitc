import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:raven_for_nitc/navigator.dart';
import 'package:raven_for_nitc/pages/auth_page.dart';
import 'app_theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PageControllerModel(),
      child: MaterialApp(
        title: 'Raven for NITC',
        theme: customDarkTheme(),
        home: AuthPage(),
      ),
    );
  }
}
