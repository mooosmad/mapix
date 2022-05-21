import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/root_app.dart';
import 'theme/color.dart';
import "package:firebase_core/firebase_core.dart";
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hotel Booking',
      theme: ThemeData(
        primaryColor: primary,
      ),
      home: const RootApp(),
    );
  }
}
