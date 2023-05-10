import 'package:flutter/material.dart';
import 'my_navigation_bar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );





}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Programación Móvil 1';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyNavigationBar(),
    );
  }
}
