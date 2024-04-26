import 'package:flutter/material.dart';
import 'package:guess_card_smaller_or_greater/widgets/menu_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flip Card Game',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 210, 14, 0),
          //const Color.fromARGB(255, 12, 0, 67),
          foregroundColor: Colors.white,
          title: const Text(
            'Flip Card Game',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: const MenuScreen(),
      ),
    );
  }
}
