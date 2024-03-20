import 'package:flutter/material.dart';
import 'package:guess_card_smaller_or_greater/widgets/game_with_countdown.dart';
import 'package:lottie/lottie.dart';

class TimerGame extends StatelessWidget {
  const TimerGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GameWithCountdownMenu(),
    );
  }
}

class GameWithCountdownMenu extends StatefulWidget {
  const GameWithCountdownMenu({super.key});

  @override
  State<GameWithCountdownMenu> createState() => _GameWithCountdownMenuState();
}

class _GameWithCountdownMenuState extends State<GameWithCountdownMenu> {
  final textEditingController = TextEditingController();

  final GlobalKey<FormState> formController = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange, Colors.red, Colors.amber],
        ),
      ),
      child: Center(
        child: Form(
          key: formController,
          child: ListView(
            children: [
              Lottie.asset(
                'images/cat_playing.json',
                width: 300,
                height: 200,
              ),
              const Text(
                textAlign: TextAlign.center,
                'Enter Your Win Point...',
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                width: 300,
                child: TextFormField(
                  style: TextStyle(fontSize: 30),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.amberAccent.withOpacity(0.5),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  textAlign: TextAlign.center,
                  controller: textEditingController,
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        int.parse(value) < 1) {
                      return 'Point must be at least 1';
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange[200],
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  if (formController.currentState!.validate()) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => GameWithCountdown(),
                        settings: RouteSettings(
                          arguments: textEditingController.text,
                        ),
                      ),
                    );
                  }
                  setState(() {});
                },
                child: const Text(
                  'START',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange[200],
                      padding: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30))),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'MENU',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
