import 'package:flutter/material.dart';
import 'package:guess_card_smaller_or_greater/widgets/game_screen.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 12, 0, 67),
        foregroundColor: Colors.white,
        title: const Text('Flip Card'),
      ),
      body: const GameScreen(),
    );
  }
}
