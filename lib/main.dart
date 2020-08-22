import 'package:flutter/material.dart';
import 'package:quotes/di.dart';
import 'package:quotes/ui/AllQuotes.dart';

void main() async {
  await initDI();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AllQuotes(),
    );
  }
}
