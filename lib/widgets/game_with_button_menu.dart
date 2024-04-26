import 'package:flutter/material.dart';
import 'package:guess_card_smaller_or_greater/constants/assets.dart';
import 'package:guess_card_smaller_or_greater/widgets/game_with_button.dart';

class ButtonGame extends StatelessWidget {
  const ButtonGame({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GameWithButtonMenu(),
    );
  }
}

class GameWithButtonMenu extends StatefulWidget {
  const GameWithButtonMenu({super.key});

  @override
  State<GameWithButtonMenu> createState() => _GameWithButtonMenuState();
}

class _GameWithButtonMenuState extends State<GameWithButtonMenu>
    with TickerProviderStateMixin {
  final textEditingController = TextEditingController();

  final GlobalKey<FormState> formController = GlobalKey();
  late final myController = AnimationController(
    duration: Duration(seconds: 1),
    vsync: this,
  );
  late Animation animation;
  @override
  void initState() {
    animation = Tween<double>(begin: 0.0, end: 1).animate(
      myController,
    );
    myController.forward();
    myController.addListener(() {
      if (animation.status == AnimationStatus.completed) {
        myController.reverse();
      }
      if (animation.status == AnimationStatus.dismissed) {
        myController.forward();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 20, 1, 105),
            Colors.pink,
            Colors.white,
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Form(
        key: formController,
        child: ListView(
          children: [
            Center(
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: animation,
                    builder: (_, __) {
                      return Transform.rotate(
                        angle: animation.value * 0.7,
                        origin: const Offset(0, 200),
                        child: Container(
                          decoration: const BoxDecoration(
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Color.fromARGB(255, 20, 1, 105),
                              //     offset: Offset.zero,
                              //     blurRadius: 50,
                              //     spreadRadius: 0,
                              //   ),
                              // ],
                              ),
                          child: Image.asset(
                            Assets.assetsJack,
                            width: 200,
                            height: 400,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    child: AnimatedBuilder(
                      animation: animation,
                      builder: (_, __) {
                        return Transform.rotate(
                          angle: animation.value * 0.3,
                          origin: const Offset(0, 200),
                          child: Container(
                            decoration: const BoxDecoration(
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Color.fromARGB(255, 20, 1, 105),
                                //     offset: Offset.zero,
                                //     blurRadius: 50,
                                //     // spreadRadius: 100,
                                //   ),
                                // ],
                                ),
                            child: Image.asset(
                              Assets.assetsJoker,
                              width: 200,
                              height: 400,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    child: AnimatedBuilder(
                      animation: animation,
                      builder: (_, __) {
                        return Transform.rotate(
                          angle: -animation.value * 0.15,
                          origin: const Offset(-0, 200),
                          child: Container(
                            decoration: const BoxDecoration(
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Color.fromARGB(255, 20, 1, 105),
                                //     offset: Offset.zero,
                                //     blurRadius: 50,
                                //     // spreadRadius: 100,
                                //   ),
                                // ],
                                ),
                            child: Image.asset(
                              Assets.assetsQueen,
                              width: 200,
                              height: 400,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    child: AnimatedBuilder(
                      animation: animation,
                      builder: (_, __) {
                        return Transform.rotate(
                          angle: -animation.value * 0.7,
                          origin: const Offset(-0, 200),
                          child: Container(
                            decoration: const BoxDecoration(
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Color.fromARGB(255, 20, 1, 105),
                                //     offset: Offset.zero,
                                //     blurRadius: 50,
                                //     // spreadRadius: 100,
                                //   ),
                                // ],
                                ),
                            child: Image.asset(
                              Assets.assetsKing,
                              width: 200,
                              height: 400,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Text(
              textAlign: TextAlign.center,
              'အနိုင်ရမှတ် ထည့်ပါ။',
              style: TextStyle(
                color: Color.fromARGB(255, 20, 1, 105),
                fontSize: 30,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              width: 300,
              child: TextFormField(
                autofocus: true,
                style: const TextStyle(fontSize: 30),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                textAlign: TextAlign.center,
                controller: textEditingController,
                validator: (value) {
                  if (value == null || value.isEmpty || int.parse(value) < 1) {
                    return 'အနည်းဆုံး(၁)မှတ်ဖြစ်ရမည်';
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: () {
                if (formController.currentState!.validate()) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const GameWithButton(),
                      settings: RouteSettings(
                        arguments: textEditingController.text,
                      ),
                    ),
                  );
                }
                setState(() {});
              },
              child: const Text(
                'ဆော့မယ်',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'ရှေ့သို့ထွက်မည်',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
